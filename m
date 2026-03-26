Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE433109E55C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22FD910EA0A;
	Thu, 26 Mar 2026 06:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dWjq8EfO";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1439510EA02
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:58:43 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c76682712b5so236555a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 23:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774508321; x=1775113121;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBshhy+mNMex3q6qeAt9akvxxHs1wV+jeuHZOVkhpyw=;
 b=dWjq8EfOV7rkMP9tDLZyDJkNMpfbQ+RMu7h3hm454gcQNorKLGsSUQ80u4I9AUiWkl
 JvziMlogKhCjpp0NL2tZQAValy0y9mBMjppKA2hEOA2TUltuyMVF0WdwscHZehx3T4/z
 rQJxeWbwy7N6jcVKc18AB7L/xa0OJcKVQK+1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774508321; x=1775113121;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LBshhy+mNMex3q6qeAt9akvxxHs1wV+jeuHZOVkhpyw=;
 b=rGnmnJ7xHRw7pX3aVFqjIthOS8RbV35uD7o+Sp4zHKr6NWqYcRV556vkplMim+tIRK
 tXHf2k6n/MNNr5ryMK82mLSWrAKjAfKLYdRyCpBmuagbxYJgKOKaS5ucHm32JZfoGRIr
 qTWaNRwA6QdkjRgyr2019dP2ql1DpiBL7XlI4y91UkqolPkzhj0kyCIcrE7SV+qVifGz
 eOoPl6QVCWbBDjVFXhvABBpHjEGW3tZFRkhg4vfyYWIWvzFIvfpd6qJJMzWBuojU2DVt
 Vw/tk4L1cKMblXNg9hlAz4FaGA/WPqE3X+83MZybTY0MMnidMSjdb4BOVDkW4HwMjrz4
 BoWw==
X-Gm-Message-State: AOJu0Yx9azr/RUq9QsnstVuUsk7z53sT0obThqsgIQakKuIMFxNJE2dW
 Sur0oJgRdzjtfalj2iXWw0AGD0J9d7aYHuAuFuSZ0Be44JX2RbTG8JL7kyVjiCNG2A==
X-Gm-Gg: ATEYQzzI37VR0lthL33oXYA2JpgSp97ihWKL9bMQnkd0zmVmLAD70ErO+WYsPW9B8j3
 Pb38aKzT1cZ1PxxOv98xoz5RuQp25lnfQzUR0QFCg30yL/i0PEc4Dyu/OtivdBGskVphChFMJT6
 4L2XFEMrD90g7HbVjQ3+clMMm1DcQjtuLPyBta3r2AT/8yXTYEmNbR31nhjAACr3GhZj7Uo28dp
 +T69az1PDEnryCYHY/Si3cs7i/w2JIgYNISlkLQ9B7FI76X09U9rAYmpIP5GUQ0UMpGzQM66NyX
 NtAFP2NLhcjoZ1Mqh9OuMLFqRDBRh4GtDIB7u7KdXxE8cl1Q49iim0UJ7/KwGZ6cEh0gKX8j8Mh
 SFjF+h7xbYfTdHOXUR79ggJGHYOvXZsapwVUTPgGTzSTt6iqn/DrD0t7rOnEZdjq5Ys3ei6OYk2
 VsrtU3PD6nyUEn7tEtfjd5ypI6sGryzzFNkVzKnyByGSp/9ABYDocSqvVIkgw9JM1fk9/pzRwEw
 +ZrDz1ka2HAaLcm5is=
X-Received: by 2002:a05:6a20:7f99:b0:39c:2ca:7431 with SMTP id
 adf61e73a8af0-39c4ace2f30mr7021047637.28.1774508321014; 
 Wed, 25 Mar 2026 23:58:41 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76736e54e4sm1345254a12.0.2026.03.25.23.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 23:58:40 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260317040034.617585-1-wenst@chromium.org>
References: <20260317040034.617585-1-wenst@chromium.org>
Subject: Re: [PATCH] drm/gem-dma: set VM_DONTDUMP for mmap
Message-Id: <177450831914.1057981.1410690079127094921.b4-ty@chromium.org>
Date: Thu, 26 Mar 2026 14:58:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 17 Mar 2026 12:00:32 +0800, Chen-Yu Tsai wrote:
> When the mmap function was converted from a file op to a GEM object
> function in commit f5ca8eb6f9bd ("drm/cma-helper: Implement mmap as GEM
> CMA object functions") some VM flags were not lifted from drm_gem_mmap():
> 
>   - VM_IO
>   - VM_DONTEXPAND
>   - VM_DONTDUMP
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/gem-dma: set VM_DONTDUMP for mmap
      commit: e3eb0e70815cc02ea15298818e37d8b0a0930ab1

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>

