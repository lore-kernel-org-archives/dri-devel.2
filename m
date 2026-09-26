Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15C8CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9ED10E8A4;
	Mon, 28 Sep 2026 08:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rl7H3WXf";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F186810E033
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 19:52:06 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so9523855e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790452325; x=1791057125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=quK4ESbWBNP7NCO/VpFQ3aGBfCDPjj+jYULDZLt3xFY=;
 b=rl7H3WXfj8/HBHlorW3den9cAx5+cuQIfr05gvIXXT9NsSE4GzGgeCAHGI9gPMtDKB
 rT6RJE2oa4k+VdABU0Js8SCXafuUSJNuC7mMWjpp2LKJYJP1/X3z32EL0ZvHdO0HiLWX
 WfbrNrYD+9IktxpOTHjj4VOIfzL3X0h/2ipj0LM5EE4ReK6lOT3DLOSYc5/PZEB7Sfns
 Pf+m83wGJE0dbu/U4kPdTU982Te87K2QGeVPrvic7Y4XwhqKsprpm89mzSxtqUXsTF1h
 l8kldxaseyqF/OBu3w7fv4oa2CXCPpgY6x5XIDTa2HGsgskeQvDADjdPOO7MaLrh9T6h
 ceOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790452325; x=1791057125;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=quK4ESbWBNP7NCO/VpFQ3aGBfCDPjj+jYULDZLt3xFY=;
 b=sv6R3IrY2UH56oq3/U5pr/Gglb1SbgNfzAI1PmHSQVcpWAM3ZDzpSTe+SAZUCi4kYM
 p10DgxZS7CfsykxQsiap+/ag5f+BSL1bfwyIz+ER/6+VIl6heGUv766UD+gzsbXia5lC
 RChJTs1QpERkGMUrOB67S59cbIL/qPLrRSKP1oAVvhO+dyg1XV5dP6qLJzUhGvRUnxTY
 E0e4xmgrLfNqG8aIQBEoKGDqAxwCgO1nNJhV2vLviCqu/QBtarZDS+gu7I8droz41EDb
 knVkIeYGR8XFmclTfo9VVNIHMh2OkFfcnKzujF/p9ct9n/ultdNUJkqMke8rg8E46i52
 FaNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+/HLn9G5FjHv2WehRdqfTxZbVdjywE6rm7J2i9RvcCV0HXLMo0ymbPNBbcUmzKQv9Ss2QtcDFwC4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYPVF2qfD5PSmAfEmVcLcj5P6xMA9uhYxuDBqaGmXLAGJ1bxVt
 tTuaSngIqCiCIM1BgeodWVxfWiFKadutU25rROdLn9eOV0WJAHtCFUlr
X-Gm-Gg: AYBFou2efWpbufft6yRdUKxUKbsht6K0Qf8OfHjeXLGGILl0uTyHCIc+DmnbaRAiLVy
 n3i4jjRw0Cy935xOEPqxCFbCHjHpupu1BM1WPxnIwRz3QvBWBBLSzJ/bzRZVv+PTvBDnBXtu4Uo
 ph9pLZAnX5LUEij0jL2AuuUzeElWLNGHR8PEtPmhiJh8BMMuey9KL1sy89wpVxKPnnCPVpTTf1p
 SGabjsCBHSrm7Jbt1dYDnrsjCXSBqAieV5t2Gwvrf5+1+l4JYCRmn0Z7/IO7PhpOfchGb8j9/BG
 pv/Yhv4ZppIsJD8rfuIVBFZJGYypFAxbsQCJW3kOI4TGJSmTKHQzuakiN6yY1xreC6tl1oo0TaW
 kXRdqwtO3N74xVKfdvgw9JclF7ZSsxnmBG1MIa9Yfcjd4f5jON7egO3j5iRDrQE5Jwpwn5a5x35
 2riIjVF+6TpY4n42ACQIZYPC3YR20+U0NYa3xIXFKxOITao+QL+MSl1353e9yQ9SpyhGBelgNM2
 gwOh1FXYmW5q+tiWw==
X-Received: by 2002:a05:600c:4ec8:b0:49f:dd10:3c71 with SMTP id
 5b1f17b1804b1-49fe66c61c4mr167010005e9.11.1790452325101; 
 Sat, 26 Sep 2026 12:52:05 -0700 (PDT)
Received: from localhost.localdomain ([94.252.74.168])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-49fef4fc959sm139458915e9.2.2026.09.26.12.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 12:52:03 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/dp: don't mark the AUX backlight enabled when
 enabling failed
Date: Sat, 26 Sep 2026 21:51:55 +0200
Message-ID: <179045227485.41069.12855843493298872118@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAD=FV=UohyFHM3r4i6NoDbzVFpY9xZzg_=FvGFhBgScaCUwH2w@mail.gmail.com>
References: <CAD=FV=UohyFHM3r4i6NoDbzVFpY9xZzg_=FvGFhBgScaCUwH2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Doug,

Sorry for the muddy commit message. Unfortunately i cannot reproduce
the enable fail. I found the unchecked return while debugging eDP issues
on glymur. Please drop the second paragraph when applying, or drop the
patch if a code-inspection fix without a reproducer isn't worth taking.

Oleg
