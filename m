Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469C0C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8D010EF01;
	Wed, 15 Jul 2026 07:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qh2tgFP4";
	dkim-atps=neutral
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9FF10EF01
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:28:48 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id
 006d021491bc7-6a3d9aded38so200506eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784100527; x=1784705327; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UxQ0BxbdBsXkQRkJTN/tYd3cFPb7z2YjlCsAC7VkUCY=;
 b=qh2tgFP4NudfV1XQoB6a1AuDSnP77pzBul9/AzINN5J1L4HUKKL4w7muthJI5VheBT
 OrNRpo4juvYIzCUzUewIwl5eDpjWNUUpy/k/IIOP3jQfJTPpKb6ngWTGs8k6MAxecw+B
 YmEUwPTRJ+7+bpJ9JU3Oq3uSo0E89Qiw452ZM/nHCgOl5fWTVSY05z9WLURaC0p4FKiI
 Jb5Vi8VVJ8PUMjE/U/LZIznuU/fWr8P3sP/P5uBWA/z12F2m64MgfQtDDpWeLf/cYnDz
 gpnZmViPqSv6xL34bvOzPgOQnMhe7V28RJIzeJ0b+vcBrJfUvmHmzDciwpuc9MOWnkcS
 r0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784100527; x=1784705327;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UxQ0BxbdBsXkQRkJTN/tYd3cFPb7z2YjlCsAC7VkUCY=;
 b=Q9fFpC21070bsET7dng+5Zf09FPXwmm4zeEPlUOCBpsWOIi8QemQb9Yd0mLoVr4QU9
 zq9Fr0jtV2mMUIjRSzZ9wQXpcab+3E1042sOPaGoP77C+vYLnM84ilTlV9jdrgqF6Al0
 qGuDDe9bYjUCuHNCgCpbDl5CkfjglIRq7uU3caqToetUNBo/wprHwN+rmJDkznGlU/wa
 TPmQNpnDEYUgetWHKZROVufjvdRxtFM/Y5nxE/lhIVics8Dfl8aYVoC7ekf196Ex7cqY
 YOd/5FNxCHW2hy729mLNfGgGAckYbeiTH/MZH9hGIzzAS6Rr+UGPtd5yYYLitPXpAZxG
 RUtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrMra8YQ3rwaC7x90nyj64g/miNDo1PPSFFbKDSpjXf3gGzjEAD6sqEZt+wZQxpuZhwkCeUW1Hmxc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyFQyx7Bvfq5OQ/D/diG9pD8ShEkYuU+lZbe8faO9mLlE3Ft4D
 nn+Fbf3IZ8aj1Ge/OLmDUORs1/O3A0Wxtz8iKSKHlD6msgwfG+CIoBN1
X-Gm-Gg: AfdE7cm0beoASsOlmee26fQEeeLe1JlJ4PlH0gCy75D5/Zx2R6HRlf3ZL4J58SUHDbF
 qo2eK2tnj/Z25TUDaXi5WUNkqsIFXluxjsIw3raOpdqY4tV/0k0oVKUge628VSCvdHizBaA4sGK
 MJKU2ItNnZ0rCyeCcHCXz/64fbs3LWtcE2ieyb323i2IxMbHFW19heDl4wU+c/GdhyeV4RB8l2R
 +CLnjCYKDYoI6heFhaSWwa5sds4wJMtYCmG2ewXrxk4nnCreFzgdPGrJv1xkCm8rA190V/ar4vt
 XTTnUjS53HVNbN1sxzB5Vz6YUmBULof6Qbir3BGEVjc0ibRt9JklG2iYvpjgOxPUJl5+2w0qjCv
 7s4F+VVzniKYhL4G2N3KtY7z7Qif162otfiCLpPT140HiGjy9Ai201nNmItakxElkk6dmDn8+zm
 zVSTDi
X-Received: by 2002:a05:6820:f021:b0:6a3:1b9a:48e8 with SMTP id
 006d021491bc7-6a39bee8e8bmr7442734eaf.33.1784100527217; 
 Wed, 15 Jul 2026 00:28:47 -0700 (PDT)
Received: from localhost ([74.80.182.78]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a36a3b0d60sm15711707eaf.0.2026.07.15.00.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 00:28:45 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:28:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
 tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging/fbtft: Minor cleanups.
Message-ID: <alc2pxlSIEv5FMWa@stanley.mountain>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
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

On Tue, Jul 14, 2026 at 10:09:38PM +0300, Panagiotis Gravias wrote:
> Solved some style errors,
> parenthesis spacing, aligning arguments, replacing udelay() with
> usleep_range().
> 
> I hope this makes future checks with the style script cleaner and more
> helpfull.
> 

With old code you should search lore for why it still exists.

regards,
dan carpenter

