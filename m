Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DEEC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64A010E04A;
	Mon, 29 Jun 2026 08:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iLlT5YQe";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3430F10E04A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:44:03 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4704d652e9cso1083301f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782722641; x=1783327441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGm9QONZukO2Q5rdaZt121dw8G3tFHNBSookGlxPwSY=;
 b=iLlT5YQeBdHRBfz6g1dXeNBYt0BQU6nSPmugp+JVKazVYv8cHpokYTD9HEvJXoPlTB
 R36tMkQ+EH+RCczxBROtHGD7ivsJWJBLMXurrntXsMLBUx6b1V68idKWQG42IdDX63Yq
 5Pu4FPECLNaL8xSzEWF92Q6WcqtcUB+Ahw08wtYmfMar3lx6i9sOLiud7AjKNGvApeVn
 vjTMtkIuQc1JqsgDAlrTqpk666hr+hdr9d2khf+h9QeyG+31zLy5u8EZKiyQloTf6r+J
 8n9Q8n5W9QnPymoEg9GwPfU7pnucxusLw/DEw/nQSp71maPKuPOrgGrhdVL4Nt5P9qvr
 TgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722641; x=1783327441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PGm9QONZukO2Q5rdaZt121dw8G3tFHNBSookGlxPwSY=;
 b=S8C97Vhq3Te5k3FGdQJjCZxoJ30yw7N9FLmBq46vgarupMEagc0cVxFATRtdLj1yuZ
 0lQ5dUIJRH4nuCqHmogPpU2BS0TfxBajk7u62ZjUJzBBR30vDHVweRWMoErgUVxFlsm4
 tVGQ6egdNA4cyaiq7fFtpp/YL9cw3yeoFPCcbOkhG0dn35OnAB5MMdAx6Cmh9z23Z8Yy
 aGSTM5NL2W7CDbjKQ3/dafiD1pg60TFP+UHQz0b3mnk02rzO1b1ZhNVMJtv6WJfzA/Ql
 8E+pUPUvcBb2vtPfYca9+8UKHe14aQk+EMIdbEBDXg40uMj2XpKOrywfT0B3jrRwE2Q+
 XgvA==
X-Gm-Message-State: AOJu0Yx4x0HFuZgD3wGHgZ9BrCQgvsho04lnMOxjr4L/gbtDggvY41NS
 6KrU8GYuwRn/1+lhXtySXaWdsJAUN7gGid2z3Zeu9NHlDyZyI3uF7ASX
X-Gm-Gg: AfdE7ckbx9iycujiHilpeEMaT+EKER+5b8JqKNNkKM/MDF/HjqXPuKbY5jMUZGM84ui
 c/lIdzDC5WWbSUfzk/poNhlDpYtfuRMPlmNkL1iVBi8T2Gyc1sVDHSRxgaWc9hlU03LTRi6aiuX
 m6MQaBfVabivC+lN7yJ6BhBjCyzbw+CGpWbri0+52KI9Sc0pl3wrQM3emBedJTUf0AtW7oFvxjs
 /sbG/LQv2DSbvtnhhz8YIcH0NEZmJQ2eVy4d2nwnlDKfLIatOyGv46jhlQXPPq5lEYa2WE1YnSs
 YyVJNQPjHQfu0vta3Cn7NddAH+Svj67RkqvPxrjw2a6oSj6ylE1Diur1Vuo2OxYdFiqrH/uYgtv
 Tf5vE7PvePoBNAyePHvOVwbGpz6ld25CYyQAAQSUJaeeeUDw91Ea25JODMdDVS0KwMYSl+8F4hP
 kOZpg4C0rMRAG0fHO6AQAbEe9WQcQ=
X-Received: by 2002:a05:6000:4210:b0:470:4d27:97a3 with SMTP id
 ffacd0b85a97d-4704d2799d5mr12518285f8f.1.1782722641174; 
 Mon, 29 Jun 2026 01:44:01 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f8d6f10absm41208583f8f.5.2026.06.29.01.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:44:00 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 1/3] drm/ssd130x: fix column and row end address in
 partial updates for ssd132x
Date: Mon, 29 Jun 2026 11:43:16 +0300
Message-ID: <20260629084317.10265-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622123631.8B4A31F000E9@smtp.kernel.org>
References: 
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

On Mon, Jun 22, 2026 at 12:36:30PM +0000, sashiko-bot@kernel.org wrote:
> Pre-existing issues:
> - [High] Potential 1-byte out-of-bounds read past the heap buffer in
>   `ssd132x_update_rect` when device width is configured to an odd value.

As stated in the review, this is a pre-existing issue and is not touched by
this series, which only corrects the SET_COL_RANGE/SET_ROW_RANGE end
addresses sent to the controller.

Gentle ping on the series -- it's been about a week with no comments. Is
there anything you'd like changed for it to be picked up? Happy to spin a
v2 if needed.

-- 
Thanks,
Amit
