Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B8606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l/vRLWnJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iVjlBFyJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 284EF10E87C;
	Tue, 24 Nov 2026 12:50:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F94210E87C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:50:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuTV5120224
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S+Bu1InFLW19DgDCJwbNOXYUTACmlNtymsROLTtp7yQ=; b=l/vRLWnJs0JuaXCz
 Wi8PxMO2o1k5K1HMeJ+A8bpug1uc8IGZh5oi7El9UE/B3xqMFLyYVlfMXAoBBYhZ
 /IAK88MuYs4fR/fhLY4hVUCt03HUtCEhPJ+Zl9pCVcZJ3+3asBQI7EdOITd0RwXq
 nL141PicfrhKoTGEv+H1/LVrWIxhz5TvE0/mHPoomj0dG5C3Z/snm7kHM+scHruo
 dFtfPUxS9al0CY2j2eCOrRYzf9W0mt7nQ8JMLLeMW1A4Ky4ha10ZUaWo9O5ZK2bL
 ayYqVhuN3n/EG3l6dHppCN3x4OK3/Q6A1z24jLv4yWmZo2jELKBwclV9yyKMR6wX
 LM83gA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f33df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:50:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-386177b0516so11830326eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795524626; x=1796129426;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+Bu1InFLW19DgDCJwbNOXYUTACmlNtymsROLTtp7yQ=;
 b=iVjlBFyJV1EbNRmdHT9p+wjI51yiu6zM0MWm1c5E5C/tV/aPVpsUk/82qWrw21s5ua
 aMv/diezOVzThnP6v7XUF1ijWEQyJB67nHcuef5d39o3XvpN0NDoQU0E2EB4gve7u3jo
 6lnAB0aJe3IwKJqWuktNmtczVFZ/n2OGP1MO5Cjez7CAqhLuyBLI3ncnJinXVa1PPRtd
 8LGF0yLF1oE6WGg0WPpjZUo1iZtp3+fmTaw4lPGW8X9ihuRhLr13pTlb739i1TaWsWQC
 Yldlbfkf/Fs6gPceysen6KY1KmKCFT9i+nq5AGV+LTVkBZFKGbJ7rL2HYo3diAe1nu1y
 zKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795524626; x=1796129426;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S+Bu1InFLW19DgDCJwbNOXYUTACmlNtymsROLTtp7yQ=;
 b=vrHbLZ55qo+uuq7o38551fxyQuLL8ka+pnIY3IPoQrXaVpayyphr/kSdb/21F1tHRl
 3OhIjddW3LJAMDlnw+nYoOJANRG2565RrQQ7h/xHo/IVSQ2vIqU0tClbMRcJMqtcf7Ef
 deQLpnYJkJ+vSmoqCuyVPoUgmSSlwS2hklYL06yoinafNdF3UMO51oGUNKTO3BUy5lmY
 J8eZLpACK9hCVVd04YEvB19qzilGb0owkP1S/kF5GMX/KFWkYCSAeKUKKoPncbqzqNHJ
 b0urW2t9JeI9oeoLgA90+fIb82vg0cZtDiKzlCB87ltuQ+YjOa1tva/Skjn8jl3yflPU
 BxnQ==
X-Gm-Message-State: APuU4Z+c3vT306k/bHumeKSlSGiXqNQ9NgiI8pJ0LGysWJl5XiZ29uC9
 moNIV9laizRFdJmmh35TYidTrmRD5bcLKAa2cTpp48QQip9uBuKWl2xNdwzXBZ2rZhgNdvotG0W
 nHYioDDR5Kj63QhBb8F7F9QVGfbhAVGCHuxKPF7/zLaWzxVij9ob9Xm0VwOjghdeKb+dYcz7OyZ
 dU/b0=
X-Gm-Gg: AZFdTZdku0NGbDKuTDC9WtMRMdsTbfcv/fpIdFPnhYLe8sacMYa+/x+6UW5c7kP2O+w
 G+dKQnW5aXrAwxVeW95CCuobuCDtFyabVDrf5SgUUnCvL84uqEc5x3eIbFwUsqfA0rYdzVVFgMA
 /xgfYBXbrORqAmNAg8j+f3hqB7FC0GMkelYZhtpOi1fiG1W9YotY+K5nl86cVMayY9mxKpxlxDr
 ZW8jPPRxoM5eOfeAdpAbJ+9jBV4Ao/FyYtlfPPn3zoWfRFZja+O3EflTHHRRSziBzWc/SqkI8jZ
 eJvNMFm9fFAcuCyFnO0cNMmA3oOrot/ZiMYaN4XJ26qbr1U6g9+23SpEllcgerh2CemcFMgMGRM
 tfqJ7y2pWNVI3Kr/B1q/sKd7PNvAejqcyshGvE00zn9X56ym5yFJ+wfhCFPzUKvvU/C3449qz7J
 zk
X-Received: by 2002:a05:7301:dd86:b0:351:2958:1740 with SMTP id
 5a478bee46e88-3856fb641famr14864672eec.37.1795524625999; 
 Tue, 24 Nov 2026 04:50:25 -0800 (PST)
X-Received: by 2002:a05:7301:dd86:b0:351:2958:1740 with SMTP id
 5a478bee46e88-3856fb641famr14864633eec.37.1795524625111; 
 Tue, 24 Nov 2026 04:50:25 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm56119313eec.4.2026.11.24.04.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:50:24 -0800 (PST)
Date: Tue, 24 Nov 2026 18:20:19 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
Subject: Re: [PATCH v3 5/9] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261124125019.m5nksa3n7pk2pg36@hu-mojha-hyd.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-6-mukesh.ojha@oss.qualcomm.com>
 <sashiko-outbox-219164@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-219164@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0OSBTYWx0ZWRfX0XgEB/XNnaxu
 gyVPQOprRQly34MulSugx5MCP1mmCHcztCLk1rTILSsBEFeO7zTS29CD2DPPpJN9bFa12K83/PC
 oan175IAZZZcTtEXlxk7Fw+jOFcGUJA=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b058812 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=1BlexpJj4gX76_l8dI0A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 9VAONckIKs1OkAd3lvIxWn_4WZqLQhza
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0OSBTYWx0ZWRfXymRncn0F4U1K
 arNMJ5N/HEwlg8Gu1hQDA8Ff0IPsxQMtYOpFpsnszZOP8cAPGdeAieBbYOJqc9w70+Ly0brdG4o
 peMvnmMcgR02+8wBojk5Hw9EtWBLzgIHtGUoZHm8g5ItKtyaqn5djPVi2erjwuuqtJ7tuKlniuh
 ogSjnQNiFjj/Q80qooHj3uNHVjgDVJkWAp3E9pgyv0PJGULCL51wAqoBBqQ+nw9ZVR21F64FD90
 irbGhZm7+k9S8Na+W/GeA9YBxNGCWy8dxaVMgS/FlkviR16UT3ukZugl8TsUQrEPWN4WjMA5AXc
 FR6QGEiBZN0N96BxgWrXgosyFVW5p/KVaoiRRZjSEcgA0T5J0b8beUjVRX6sHCw6MEvRm6eQsph
 o1l/WF/3IWby3c0Cv++zcFS96XX7rp0IJNUfHhvfD8qiyW+TAPTxhFpOnLijqxir3FvRRCDGyUu
 oSyvrchr1yVCOjsBEKA==
X-Proofpoint-ORIG-GUID: 9VAONckIKs1OkAd3lvIxWn_4WZqLQhza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240049
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 04:24:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] media: venus: PAS metadata buffer leak in venus_load_fw() and
>   venus_boot()
> --
> 
> commit 197c5c883871fbbcc35bb55913a4e0eb4bf2cd11
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> media: venus: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit embeds a struct qcom_pas_context in struct video_firmware and
> switches the TrustZone firmware loading path in venus_load_fw() and
> venus_boot() to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> 
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 3a38ff985822f..704343e241dc6 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -117,21 +117,22 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
> >  		goto err_release_fw;
> >  	}
> >  
> > -	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> > -	if (!mem_va) {
> > -		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
> > -		ret = -ENOMEM;
> > -		goto err_release_fw;
> > -	}
> > -
> > -	if (core->use_tz)
> > -		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> > -				    mem_va, *mem_phys, *mem_size, NULL);
> > -	else
> > +	if (core->use_tz) {
> > +		qcom_pas_context_init(&core->fw.pas_ctx, dev, VENUS_PAS_ID,
> > +				      *mem_phys, *mem_size);
> > +		ret = qcom_mdt_pas_load(&core->fw.pas_ctx, mdt, fwname, NULL);
> > +	} else {
> > +		mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> > +		if (!mem_va) {
> > +			dev_err(dev, "unable to map memory region %pa size %#zx\n",
> > +				mem_phys, *mem_size);
> > +			ret = -ENOMEM;
> > +			goto err_release_fw;
> > +		}
> >  		ret = qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
> >  					    *mem_phys, *mem_size, NULL);
> > -
> > -	memunmap(mem_va);
> > +		memunmap(mem_va);
> > +	}
> >  err_release_fw:
> >  	release_firmware(mdt);
> >  	return ret;
> > @@ -237,7 +238,7 @@ int venus_boot(struct venus_core *core)
> >  	core->fw.mem_phys = mem_phys;
> >  
> >  	if (core->use_tz)
> > -		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
> > +		ret = qcom_pas_prepare_and_auth_reset(&core->fw.pas_ctx);
> >  	else
> >  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
> 
> [Severity: Medium]
> As reported by Konrad Dybcio on v1 [1], does this leak the PAS metadata
> buffer in core->fw.pas_ctx.ptr?
> 
> Unlike qcom_mdt_load(), which passes a NULL context to
> qcom_pas_init_image() so the metadata buffer is freed immediately,
> qcom_mdt_pas_load() passes &core->fw.pas_ctx, causing
> qcom_pas_init_image() to retain the metadata allocation in
> core->fw.pas_ctx.ptr until qcom_pas_metadata_release() is called.
> Nothing calls qcom_pas_metadata_release(&core->fw.pas_ctx) after
> qcom_pas_prepare_and_auth_reset() or if qcom_mdt_pas_load() fails after
> qcom_pas_init_image() succeeds, and subsequent recovery boots via
> venus_sys_error_handler() -> venus_boot() overwrite core->fw.pas_ctx in
> qcom_pas_context_init().

No harm.

Change to avoid leakage https://lore.kernel.org/all/20260925165231.10722-1-mukesh.ojha@oss.qualcomm.com/
is present in linux-next which takes care of this.

> 
> [1] https://lore.kernel.org/r/ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com?part=5

-- 
-Mukesh Ojha
