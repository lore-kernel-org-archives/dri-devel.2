Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7521FF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD2010EC1E;
	Tue, 28 Apr 2026 17:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="HHPp+KlD";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5FCD10EC1E
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=Xv4pvbi18GiL7sIHV71zeQ8uZGRfgExwMryIGqrntj8=; b=HHPp+KlDoOc2WUwqvF0tDtrBzh
 ruCGzRE21RNQxrGh9XywLjfwp32+7hIpEkfvnml5e2Umgu32Qh/uVl7FRrg1ti7FgkhljsL1RixqM
 oVySYlj+1qMcadCpgJJIxD9FxDpupMOQ+vYEVpbjFE3aAtb5KyCz5mAIura9wewdhMVBMTbhrSEo1
 drgJZhqHZ4ZYzN1R+f/qXx02rOUBOGR3xxd0tF5xLM98i008fXe3oZfGimoRvNbqFeVqLU+ueHNWz
 srOp+obsR/RPL96+lVd9o5GN4KK/bEay3UNPBe8s4hQMV7w54uhUSXJeM3JwaFXpEdgo9V73QK2CI
 CPKFszcA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wHmCn-000000021DH-0tpk; Tue, 28 Apr 2026 17:26:41 +0000
Message-ID: <47db4aad-fd19-4cda-969c-5768c8f2b869@infradead.org>
Date: Tue, 28 Apr 2026 10:26:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Apr 28 (docs warning in drm_panel.c)
To: Thierry Reding <thierry.reding@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260428124827.3910282-1-thierry.reding@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260428124827.3910282-1-thierry.reding@kernel.org>
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



On 4/28/26 5:48 AM, Thierry Reding wrote:
> Hi all,
> 
> Changes since 20260427:
> 

(new docs warning AFAIK)

WARNING: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev' not described in 'devm_drm_panel_add'


from
commit e43a8e3ad8fa
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date:   Mon Apr 13 17:05:41 2026 +0300
    drm/panel: add devm_drm_panel_add() helper


-- 
~Randy

