Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C580DC79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 21:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC7010E42F;
	Fri,  4 Sep 2026 21:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="Q8xxM+g/";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8314710E42F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=sSvUpFWW8JKivVwdga+J27ilaaR4NlD5+m5+kzr85ck=; b=Q8xxM+g/XRTlD/9/RWDWMxhIdQ
 bnmSadAa2Ncj8VuBv8mLITJWBKQhrtzOacFJLsE7wLwNQLUZ+JXSSVLyp0V7pnUKmJ76YqizAsB1L
 VlOBLMSfLsqZKM7PFZJNGxBghxCZa+kFSvlcUMEiA2yMsSLBf/NDkpjIj926gWvjzzhqdsS7jatx9
 DkoSAos+kdj2SqJCEdSJm20qvmbdfcHDI4CguzyYMend6CFvF7PH0i2OzwYYIaVOnl9iBfLARbiuN
 QdKW74TRe36Jktr31Xu2+ikPSvhI4fXsik1ZY5YYbbtArVwNCMBdmmuxLJLl7hOPd2tBIFSDDtRb+
 USyUXpqA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x2bXe-00000003Kbx-3waM; Fri, 04 Sep 2026 21:33:46 +0000
Message-ID: <5ebd634e-6d57-4f71-835e-9ff919fef927@infradead.org>
Date: Fri, 4 Sep 2026 14:33:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 4 (include/drm/drm_connector.h)
To: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <apscSgtnBigG5gt0@sirena.co.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <apscSgtnBigG5gt0@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/4/26 12:30 PM, Mark Brown wrote:
> Hi all,
> 
> Changes since 20260903:
> 

New warnings in 'make htmldocs':

WARNING: ../include/drm/drm_connector.h:292 struct member 'cnmvrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ../include/drm/drm_connector.h:292 struct member 'cinema_vrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ../include/drm/drm_connector.h:292 Excess struct member 'mcnmvrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cnmvrr', 'cinema_vrr')
WARNING: ../include/drm/drm_connector.h:292 Excess struct member 'mcinema_vrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cinema_vrr', 'cnmvrr')

Please repair.

-- 
~Randy

