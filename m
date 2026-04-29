Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2DEFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7038410F015;
	Wed, 29 Apr 2026 13:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lX7oNLJb";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAEB10F015
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:41:01 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso91458285e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777470059; x=1778074859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SE1WBDEAJ1UYNmcfE47F7BEz7WO16H1bRtYL6mvQ6Xs=;
 b=lX7oNLJbCgDx+iA3Bj20OQQV2n3xgdVoRx+fox6VUp13XH5DJ1hfdEU9WSQe+502e6
 dpQhHRE5iLv5isMAacbeBmpxK9AY/2Qu3X/dmtHaN6gspCvPqpcE8J+1QPsd+D4V95yQ
 MF5WQSdT3Nagm9ibtsj4Dy5NrVuWWm+gdamNBhP7IQzwVZSG1aCPqdqcaGUqiutZWL5H
 ycRswKOoFnBhEORpDVctCi0HneWyR1XN9MeoDeNG8Df1jo2wfmiZyxCmoei73pe4zpKk
 FHFI2eQIkrqQVzwrP++ahO/HDF2MxvzKB+G5Cks3Q8FVQYE/vupJtxVIyObUQ3p4/gaj
 l3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777470059; x=1778074859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SE1WBDEAJ1UYNmcfE47F7BEz7WO16H1bRtYL6mvQ6Xs=;
 b=Uaa6Gsm4+XWnMB/1wnF3tybnRBarI9mD37s/bb7LiiDZY0UHyeGZzzJ3zEwL/qZbBT
 TGKlXWJHUdQf9jCRDrDPxqg0xQjnbAbBM8XfclP+o0+NIMHpbBAnjD8ryY80OAEqh0Ql
 8kTmaTGiFckoaYrcjTM0gvzoiXoGNXGmBQ+Bix1X/ejfEnEpXs01WMo4pIiWQg9Fv4nl
 yoh3ShNVx3WORv/2JXRA3ODgYS/zbzTEJxYnteuZSk1Hv6QDW4dCVgp8PIRov4hOXnZs
 aM5wKOfWiMeij6qiymcXG+6xU5mUIRtsTCVNDJ05mFmavGt0sPdaWpE5tVZ2FHdLBhnv
 ho2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zeijNJ45uqHeYGNKKVfYyeEygq5PcA1SzSSCDl6td1Y1T505tVzf7+pClz/Ad4qLmGYuR8sBxOUw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3/Ye4XcKZooRvmyVhZ4+E3Q3Dm91PYdu2VETpRltigelM43fu
 C/NIi24xSxMFux5JOblGnEIz56PYTciuFIcWunDnmS+Hg0rk/fPACZi1
X-Gm-Gg: AeBDieuMexr8I8lz+oUiTLanFFXoH5AhDPrs5ya6mwBm23mJJ3qHyVdF2ELso1PHVOf
 lRqCNMOT/cJIA8txKkfsZeFYvj/Q0pGXIw3Qc1gnujPtw5QRPpfIQRY4YHRSVliSCUX2zlT5mG1
 /uqifuzJ8baq0qXhqCFGYky9cFcFmRdwViMwUdIvrKfCb4fc4PdJlkGRxUmkMmhqfqR42E7i9UR
 sN8FtH+AP1iuSIganP6HXEpwdxMdDIzFelzpEmeqCxuhgi1lcymH7Q8CzhhbATloLATTKkKDIOU
 cqL5K0fg/a1NaJIMnO3xRc34t+LTa90EZaHz6uLEL/NT4K8PLOb4U5+wnWeThp8nY0JassBPjrj
 ABeIibi3nku/HhOvr6KqkFhxIByHODeFUwSehTBs8H7clwWZXTCi1vuqnq7z/GMGpclSmO7lqaF
 BHctqOuUSIM8W0CxtNNHd7xN7e3qd3WvdlDrOUb/vylJ/56eVIY/KeoMKbPmO6ylComydI2sdPs
 /hOr1FEJw==
X-Received: by 2002:a05:600c:4e4b:b0:488:be58:bb5b with SMTP id
 5b1f17b1804b1-48a7b547375mr70268735e9.24.1777470059359; 
 Wed, 29 Apr 2026 06:40:59 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c57b579sm56656275e9.4.2026.04.29.06.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 06:40:58 -0700 (PDT)
Message-ID: <2d81e7f6-b6e4-4e3e-bd75-315c696c003a@gmail.com>
Date: Wed, 29 Apr 2026 15:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/sti: remove bridge when sti_hda component_add
 fails
To: Osama Abdelkader <osama.abdelkader@gmail.com>, luca.ceresoli@bootlin.com, 
 Alain Volmat <alain.volmat@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 4/23/26 22:06, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
> 
> Check the return value of devm_drm_bridge_add().
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: d28726efc637 ("drm/sti: hda: add bridge before attaching")
> Cc: stable@vger.kernel.org
> ---
Hi Osama,

Acked-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Thanks,
Best regards,
Raphaël
