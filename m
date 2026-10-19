Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AEECCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89C410E315;
	Mon, 19 Oct 2026 13:47:25 +0000 (UTC)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [46.38.247.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0A710E315
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:47:19 +0000 (UTC)
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
 by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j7cG22w3Yz8HnD;
 Mon, 19 Oct 2026 15:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1792417434;
 bh=YNKMO+U3lthxm+K4hM8ZjNmnNKm0FYUbQBfDIReK6zc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gpr0cQZ9ya/AeveVduxB4wIMO6Bjfms+lNCuvXls3aK9QE3YWYXRlakP9dgUS7L7Y
 Svz4xaz/G8FvV6xQkAIBJ1B/owU2Xn6bFYzPFkCKiMFjuh7YBIwU7G9+O4QSQUlgBA
 Jf/yoyqzLWjGz5Lh0++XIGEATZd90yjKhGOin8yUwsRPyT8hgk75lrK1V9QjNApCQL
 aywuu7XeBjqgUttkHiPCGsig7lB7PoUQpUKVTYUcfVJZI8Yppve2YmhWhrOsukj6DH
 4x7+ai+DnI7qBV/zt8WTD8ITP6Jhpzu9CoJrrKejP0TEpv//mibOVlJl7oYaco4WIT
 Wg03kn1xNggeg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4j7cFY6WDzz4ymd;
 Mon, 19 Oct 2026 15:43:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4j7cFW3thqz8tkD;
 Mon, 19 Oct 2026 15:43:27 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id A1D5C5F8E8;
 Mon, 19 Oct 2026 15:43:21 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c3c4d140-07ec-4402-a18b-389520df188e@leemhuis.info>
Date: Mon, 19 Oct 2026 15:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
To: Oleg Keri <okerixx@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <ar_AuRr1eaZzOfw9@baldur>
 <179096320161.1973.2852858792260211089@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <179096320161.1973.2852858792260211089@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179241740268.799053.7614387115975151164@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: A1D5C5F8E8
X-NC-CID: mZAHi/GmfJ9xo2HkEE4KHVNY31ngGahIZ3EtVrBm6I8qAw8W4Po=
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

On 10/2/26 19:47, Oleg Keri wrote:
>> This patch landed in next-20261001 and while it works on my Glymur CRD
>> (COB), on the Asus Zenbook A14 I see the following failure during boot:
>
> Same on a Lenovo Yoga Slim 7x Gen 11 (Glymur) with next-20261001, GMU
> firmware v5.2.38:
> 
> [    1.632277] platform 3d6c000.gmu: [drm:a6xx_hfi_wait_for_msg_interrupt] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 11 timed out waiting for response
> [    1.642345] platform 3d6c000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x4
> [    1.642360] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* gpu hw init failed: -110
> [    8.053367] platform 3d6c000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU firmware initialization timed out
> [    8.053584] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* Couldn't power up the GPU: -110
> 
> Compositor fails on the first start and works on the second.
> 
> Reverting this patch fixes it here as well.
What's the status here? Was this fixed meanwhile? Or is this regression
how heading towards mainline now that the merge window is open?

Ciao, Thorsten
