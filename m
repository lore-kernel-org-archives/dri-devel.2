Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34C2CD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 00:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162D410EF0D;
	Thu,  7 May 2026 00:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ianjTWYe";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BBD10EF0D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 00:36:29 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-5102582e23eso1540271cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778114188; x=1778718988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkbujpTdxL4QeLpeuCj5rDWwhE50kHp8Ig1HE4ujlpM=;
 b=ianjTWYeAIkKJR6lYN90olxyys83e2FzT7XTUy3OqGyOFpkPyQE0LuAdUgghJvyapU
 AdtFpjUVI4HFb92ip43AnrnZvATkY6gTqqu1nAspPC9/xV+bVDrCcsS17WhJJk1JT0AR
 xy/Qd7I16HjR5zjjiB2EQ0ee9UI3+TtF3OVaHivXtfv4dkQQbjlfPVzTZqiC4ne4wRX6
 o2xxVsuvxaxtwjWcVf962gkrF48wR3jWUVP08MeSKDkT4+tUA06C0rke4XBfAxkYmmvJ
 dYTmBNKh3luyxl15ZpZAodaLxyw36zj/OrHG+wWPpLMBfMgjlAniYMyWrglaBWCz3cyp
 koOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778114188; x=1778718988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MkbujpTdxL4QeLpeuCj5rDWwhE50kHp8Ig1HE4ujlpM=;
 b=i9aTtdQZ0alOzW3xVqhbU2m3iyvYZIbynYn44S1Bmck4a+2b4pA0dZKI2zohQh8Jqr
 SWB9Y9qaHlS8Vy8VeZVjWeWudiWc72toJwoHjsxSXUHaj0x2CRAqu/8uDncPLnW/6yfD
 lFDIwGvU86n7oSjl76WClpxhiYgrP8Ko67bX0MnnVpQLz1bjGz02bZDItRmlGHBTMF9P
 IIpl09aJcRYsAdvon97IvGPe7dOHgz13ldahO2nfHfPnTD4Twg/h+t8T51pkHdQsQnMU
 vWyH/6f3/MNIt5osrOHL2ayrx9w1Sw1ow40VByseBaYK1kRtWsyMvZyQX47/ovQW8F3s
 D1lg==
X-Gm-Message-State: AOJu0Yxc7EJE7m8onJFuJ/kjUFN4rm0K15onMKNZarHWe9rwdQsphUVl
 /zLNaLDUfxQnMbZIXuXr6gMW3IG9/YtHg6bUIDcx6qLHRYxneqSM/Y1Q8kinYj7v
X-Gm-Gg: AeBDietxF7pMP8TWUtYHJ0VsL78tSyCul/tdwyrq7/0qjHvwR0sNt8yReGD2lugfXzW
 WDbnMmrQgcTHc0OrUS2XiUODrIAK1Zi6svGUIJAmtCqF4nqdk3UwaSmfclKvdCa3tXFG/P4a9YR
 cXDS54wEKNC1z35Z0YFLZakVEHZoIUcqY0ZZAzJzoAsI4XRYLvlSss/JgUwpYPzjeJ9MHps/PNZ
 fuN17M30oKf2Tb4uhu3gaw2vlJgXahQ+VUO68qtQ0BTffkmNXdXaeWo5ulb9TN90XE0HX3t53Wh
 Qux9wtX1DEvGNyVXk4/4zqu2KulauUjCwIelbZVj9/wnf8xvXSaRYF5c97EGupxpI8RIWDGzYvh
 osx+K9c1efQzvwNd7wOuBXm7oKo/QuuofiYhyEwGHbgILrBEyWDk8xrEWFUOwhFhMm2NjA+L0M+
 /bxzSjToSiQQ36tO9YHNfubIGDizeRYzrwZwI3l7WILpX1Sq0Sv0RXYioBVNmSlUhTUPUeCq3EL
 TSsajnsUO2ynhOyZAxTbEHWwfc/ZnZKnyK97X0P+CoJQpicJA==
X-Received: by 2002:ac8:57ce:0:b0:50f:b3d2:6ee3 with SMTP id
 d75a77b69052e-514621fa8e9mr80391011cf.60.1778114187925; 
 Wed, 06 May 2026 17:36:27 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040927789sm165399421cf.11.2026.05.06.17.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 17:36:27 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband
 reply parsers
Date: Thu,  7 May 2026 00:36:18 +0000
Message-Id: <20260507003618.986160-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410034123.2433769-1-ashutoshdesai993@gmail.com>
References: <20260410034123.2433769-1-ashutoshdesai993@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

Just a gentle ping on this patch from a few weeks ago - no rush at all.

https://lore.kernel.org/dri-devel/20260410034123.2433769-1-ashutoshdesai993@gmail.com/

Happy to revise anything if needed. Thanks!

Ashutosh
