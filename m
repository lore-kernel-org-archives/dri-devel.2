Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05C606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nvx92ajf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0hqL5Ne
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BED10E0D7;
	Fri, 13 Nov 2026 07:07:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D48810E0D7
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:07:29 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD574BG3717384
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p96z7gHlJIyggbtxrEpMAQxh/HyR0haolziTZhbBFGM=; b=Nvx92ajfVht8X/yW
 6E06eUUrA8LIxC4ChTNzY4Dn/H6OqCctIvAELHzgOIukcltNdrMpQV3Dn/y+AXEo
 aZFBK/cXhdwjxF7uMaVn/4B5nMHN0d+2npy88I2nWbQ7TfNM6uorZvmZMUv830r0
 ctYN3auiNcTz5LFwNKHPjajTNtFfjpEt7aiKfP8iioXbID4d3gdvEANYZLAegmSv
 lEmDVj2R2HD9vwgy5hRXB8cvYroM9vTK4QcQpyrLP8vZlxfdMqGYvPC8XTbGfgAI
 wk3GRSS9K5ioCubvvH5wqzYkjvlEZYT/jF73p1UMge6E4KjO7B42v8+jXQJ+Uq04
 6yFlrA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufh7np-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:07:28 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so2563387c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794553648; x=1795158448;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p96z7gHlJIyggbtxrEpMAQxh/HyR0haolziTZhbBFGM=;
 b=J0hqL5NelIVW9Q0skbZAazhY9zsmInFzxmTJkVT0Jgb6ORdvRQ8rrWj9z9/JalktfZ
 XS0bvXslfzv4fs+qPZ+tWESP8fsPsSrzQ0efOA422RPFyBqoiHeFnSIl3GxZi7wjkAPv
 GhZciyesMpOkVZA3/spQYjpI0jVamCPVYWUA4ZUHmmx21B+PrSNT1NAVNL4T5yEKikU9
 WBQoTJcADBvQTMTTXfyMh4fzgXROshLb50+1ad/pEfGAYGEqvapPVhnyJ27IEJAhLwxm
 UCU72k4FEtkaAn0ACZLwh/ZsRou5nC/uRzJfQsmHWTWqhy67w0LvyCm1e1TwR7vsWbmj
 XwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794553648; x=1795158448;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p96z7gHlJIyggbtxrEpMAQxh/HyR0haolziTZhbBFGM=;
 b=cDKz7QEiDot1/T68G5IHIzJiSmJ54+yRkK718KxGrc1iXS0tn9tDgf/+/duJMr/QwN
 uUuCSEm/5v38cfLghLhjMg4MZRpyfHx2BhSbM7BQFbTC5wABqI2rFFathxF34Zh8f1fo
 BOh03k7Zm0DadR3hl1wIc4MZl19pW/z4CalMhBFR99h0f0ymdIh7c4mURvmbz9sXQFgr
 WY+1isclcfRXVZxye96MhgdNvw2uslbnNCEwNylZjCxFAF9+TcS5icFwkR5HzVC3iabE
 foqweAGa+ZmJh/oh7bWXsk4eRBge6IuwkOrzqjIi24rQcqFPwaIPKDjOs/5jpVhRzjhH
 iPLw==
X-Gm-Message-State: APuU4Z8souxhBMrVSvlF5mP7wD8j8Ww3RNWIqACOcz5WY2oC7iyrRQJc
 C1kFIiPUrHsWDZMXIbA10fSHay5FkR8Lvk8QTW23DKmH2j/Syzfe9N/uPEu2uHAsNrwH9zW4NwF
 /vteC7LUcJoGjcSChUNVgersKI5iXPkbKDbD6JQ8zN83JtDvNNuqXxK75y8LbDwXBkkPgoN0=
X-Gm-Gg: AYBFou39otRAeh3YuC83aKvfFdK5GNVfP0kcOYThLIB2mU0UaEMo+Y3bOPFYxIbeNuF
 BxkIfPAE42stk3TKZPLkvcChw2LDGMPyodyxMwOAyODzIaH6M3Ldgi9RPbPIbs2fDZaOEe+bARO
 mVboei7jkQ4YOzGMZuA1n/0QJEusK1pqqVuRC6T3D9D6Cnf8PnGTrdS3pVefTKRbneEwuL17/7X
 cqq2TeU7lvnq6neW/inscFTVUsDEkhynIJWkHAmvVXyCOjFPce88yID1dXK1oC81zdlt1gwlAQ/
 ce6hvkBASNbpI4Dv5PKe+sneYeLSuBWh1753/ziu4Ez6Ld0xpEkzjbZoHj4gAn4XfRJVMTCc3Kg
 zGRfTNuWJn4IZpxbObhfY73+afmh52d1CooXGBaum4ZTk7IKOGyTGNcjc+a+6akRuw45jqa33Fj
 D7
X-Received: by 2002:a05:701b:21c3:b0:1b3:a8a3:c6de with SMTP id
 a92af1059eb24-1b50306c4e1mr1737425c88.5.1794553647527; 
 Thu, 12 Nov 2026 23:07:27 -0800 (PST)
X-Received: by 2002:a05:701b:21c3:b0:1b3:a8a3:c6de with SMTP id
 a92af1059eb24-1b50306c4e1mr1737370c88.5.1794553645916; 
 Thu, 12 Nov 2026 23:07:25 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm5127450c88.14.2026.11.12.23.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:07:25 -0800 (PST)
Date: Fri, 13 Nov 2026 12:37:20 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
Subject: Re: [PATCH 1/8] remoteproc: qcom_wcnss: migrate to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113070720.f6nj2vqe3rjq6z5r@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-2-mukesh.ojha@oss.qualcomm.com>
 <20260926155932.D28DD1F000FF@smtp.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926155932.D28DD1F000FF@smtp.kernel.org>
X-Proofpoint-GUID: xs8z8-2e5wGOZONxUY0vtoPQqRVc4Zzr
X-Proofpoint-ORIG-GUID: xs8z8-2e5wGOZONxUY0vtoPQqRVc4Zzr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAyOCBTYWx0ZWRfXx7oU5tO/hSI/
 bHQVH5MzZMbKydzzjIkWZ3FpoptJk/lRfiws9ALtn+MJ60w9ZN2OUWFH78kktDN6BsM+RSLqAbf
 ut9Izucqkp4lel4Bi9WHC5vPEFOpLGWddJOo83lhEYE91ZScsVARoqj4lUq1TqdAh+ksEYV3JS4
 IYTWQvpEpMzcFFKFLNofmdE8oZGZEpZSvrMRJuLoDCJDcodwxw9Nul5ILh3K2vV4CpIJphx911V
 knRuwRe38fbYUZkic/t4yQmLsYf8N2815NKe3Z/Rf4HYEuZCoOpLCuVAXVZ7GD1562pDj01fbLq
 JOw4TsQfVjxNl9x/KdKM1iGvCeThK8nJNzWj1vz3xRvydjQGpwIP0255hN7EGtk50ZEfvJyG6nI
 8av6JpAeka7A+QIXLye1RfbQUFG9xH0af1Uf+iTJ4qvTvLLo1QmPNY1swj44lx3mlhGr0gVt40K
 mBywv2r08H0Wf6WHiMQ==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af6b730 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=dhegyi-ghjiyvhX7xUEA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAyOCBTYWx0ZWRfX/GCGw7yaNy76
 70ff50KGA1TGAG+mhTmw8QGBFxU+zoM892ug2bs+SFdRIL1T4euj7mws5t/qjEA5iJI1VtfCtC/
 X/FkFWkzmjwfZni44+8rCaQxdVyPEdI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130028
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Sep 26, 2026 at 03:59:32PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] remoteproc: qcom_wcnss: DMA memory leak of metadata in wcnss_load()
> - [High] remoteproc: qcom_wcnss: missing pas_ctx->use_tzmem = true prevents required shmbridge creation
> --
> 
> commit 77b1a378f038e55ff2a11032d9b6f243214fbb7f
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Date:   Fri Sep 25 15:57:30 2026 +0000
> 
>     remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit migrates the Qualcomm WCNSS remoteproc driver to use 
> qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset(). It allocates a 
> PAS context during probe to support TrustZone authentication with shmbridge 
> preparation.
> 
> > diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> > index c856a92af43ce..01f9076aa0b17 100644
> > --- a/drivers/remoteproc/qcom_wcnss.c
> > +++ b/drivers/remoteproc/qcom_wcnss.c
> 
> [ ... ]
> 
> > @@ -157,9 +158,7 @@ static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
> >  	struct qcom_wcnss *wcnss = rproc->priv;
> >  	int ret;
> >  
> > -	ret = qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
> > -			    (__force void *)wcnss->mem_region, wcnss->mem_phys,
> > -			    wcnss->mem_size, &wcnss->mem_reloc);
> > +	ret = qcom_mdt_pas_load(wcnss->pas_ctx, fw, rproc->firmware, &wcnss->mem_reloc);
> 
> [Severity: High]
> Does this introduce a DMA memory leak of the metadata buffer?
> 
> By passing wcnss->pas_ctx to qcom_mdt_pas_load(), the allocated metadata
> buffer is retained in wcnss->pas_ctx->ptr. In the previous qcom_mdt_load()
> implementation, passing a NULL context signaled the backend to free the
> buffer immediately.
> 
> Since the remoteproc operations structure (wcnss_ops) lacks an .unprepare
> hook, there doesn't seem to be a corresponding call to
> qcom_pas_metadata_release(wcnss->pas_ctx) when the device is shut down.
> 
> Will this persistently leak DMA memory each time the remoteproc is started
> and stopped via sysfs?

As mentioned in the cover letter, this series has the dependency "firmware:
qcom: pas: Make MDT buffer retention explicit" and as the change is already
picked, this issue cannot occur and the buffer is freed immediately now as
well.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2aa8fafc08e777e9da356307c1a0117e7f4277cf


> 
> >  	if (ret)
> >  		return ret;
> 
> [ ... ]
> 
> > @@ -600,6 +599,11 @@ static int wcnss_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	wcnss->pas_ctx = devm_qcom_pas_context_alloc(wcnss->dev, WCNSS_PAS_ID,
> > +						     wcnss->mem_phys, wcnss->mem_size);
> 
> [Severity: High]
> The commit message explicitly states the goal is to include the shmbridge
> prepare step required before TrustZone authentication. However, does this
> actually enable the shmbridge?

> 
> The newly allocated wcnss->pas_ctx is zero-initialized by
> devm_qcom_pas_context_alloc(), so pas_ctx->use_tzmem defaults to false. When
> use_tzmem is false, qcom_scm_pas_prepare_and_auth_reset() explicitly skips
> creating the shmbridge and falls back to the legacy behavior.
> 
> Should wcnss->pas_ctx->use_tzmem be set to true here to fulfill the stated
> security objective?

No, it is correct. No change to use_tzmem is required; it should remain
false. Perhaps the commit description needs to be updated to convey the
no-functional-change behavior.

> 
> > +	if (IS_ERR(wcnss->pas_ctx))
> > +		return PTR_ERR(wcnss->pas_ctx);
> > +
> >  	wcnss->pmu_cfg = mmio + data->pmu_offset;
> >  	wcnss->spare_out = mmio + data->spare_offset;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com?part=1

-- 
-Mukesh Ojha
