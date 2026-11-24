Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A66606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cvG2vhLZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FYSWKUmb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD9F10E853;
	Tue, 24 Nov 2026 12:47:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA9910E853
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:47:22 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuhJD1291461
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vKU1tpsRMwMDycc8EXvgkgxCWH/rHaq3p/k4nif+kDM=; b=cvG2vhLZC9vgVDUH
 cO+Ht6FXneXim+OQ2PA2Mb9hZ8QS589pppzwBCE4H28KLSoReicNgxvXfj2fQbLL
 Vi1ds6s51QQGbtFpgtuVkA96VEruk+1G+LFWAVstLa+tqf12vh+/jEigAOh00/Ja
 K+A7whkHda8D3sLctuwaFt1i9QGru1XP7WbHAR1q904CsLs0iIXcdd6NyeCg4Ps1
 CztuHNvzWBRFVBoLLo4ZnwoFDtOV7ejdj0noAhwOPqz2LE9CtcfsGTdWD5sdgsh4
 TUPhnc53ZjVEVK0HZCkvhlJI6ARNrTb61SGFVJfyilFRJAgctGTT21kIx2T9oC8s
 ieHKTw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukrbr8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:47:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-384c78aa0dbso6314050eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795524441; x=1796129241;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vKU1tpsRMwMDycc8EXvgkgxCWH/rHaq3p/k4nif+kDM=;
 b=FYSWKUmbxuyi/2LLBMssLb9+LZflFgOFHDyL3i361uqsUjKUFsa77JUPOmPNiAs/qI
 CzHsU0dN7j8ug3WBdYkzVxheA9PhEZtTlfRi8K/3eBj1taXvc02g+VxfmSSSOs0gRduI
 rK7GF0OOdLSUqtfdW9dnmhBSTpREt1mTi8PXVL2Et/ufvjTE1xLUrtl5ULDbpnT3tt8K
 RUoCdWSyx133nXPRJDMObXV5qv9AOMQ3gcMmrJ1MJxKtzHLQvq7dMfwH2pre2o+zgQ1L
 Ivs0lvg/YizFBhnnuo6oxwqaq5ksM8BzhQj/zSO8QNL04ixdMmL0CChi/D8F5U0DaHTp
 PwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795524441; x=1796129241;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vKU1tpsRMwMDycc8EXvgkgxCWH/rHaq3p/k4nif+kDM=;
 b=XK5so5mdGhuZQwBfBa2XpvycG3sSASgpE2X1JF0iBFIObGHeVovNWrXU6SrbccHU1l
 9Mjla+CIi93t4igr1yZ6rWofzWtfl+auPptKJwpKuSLf0c54YHGJtsQ6HnNm0WoapZLw
 prmIIw5oM/tV6+8hKjazkF/qNXL3K/JWX8TktB3+J5/LohDB8Jdf8wejjRytyUF4ldIO
 l/LnQ+GMkdweU7E8T93e+Kjx1GnXvCVUqzZ4fqyDZt7KpUC7RZcowqIeNt6dgFsZdpMm
 d5e97pKk3fuQu7xnRW58jLY+rA2aQhRoDdm5LmArKsNqAW9Fq/4G0ZVMyEL0InHuR3Z0
 7yOQ==
X-Gm-Message-State: APuU4Z9NEV6+OHHvJQxpsQvFx9uKFCcb8ox0KKwqXwjvciGsrCTZLGZ5
 OOCbxfIaIY5R1L389ypf9TDJNO9Wl4e6xjE8jEuy7kjTJ6sRzJnnropPdBDIvMgGLpOAUAGMy/j
 uZ9IDH61SFBwG6TR+sngCDR8ohzoITfLXDdpQvR23E2Ru7Th2eA0QlZFQg8BO3L8mdbcScnM=
X-Gm-Gg: AZFdTZf1HjBmlT3opnNJd2cvSSULeHtKimZ3+0ZgjOB4gNGaOTSiIeNx6dUORKSbpFV
 MdUmWYojTYhPaPJdeOWQeRrVm6GXlPM4FHB7xwRT6lo18rXSGydykEBsM01hhQKFmAvRJHGMfc2
 wCUqAeRCCFlXKCa9JqdkbtvkO+IUrMkG+z01f7oOxq8PpfePTlGcXe7ldElnEIfk5BP0pQMokOw
 /C05GqVRtVCUI8U6EhL+A/Che7LnbZs4VZkDUweQqFU32eNztJ+9AYNEjvuevOOwhCyjpngqDf8
 74mKH5ISoLsCftC6rGDrksJlK7kPs2AQaCx8+0iteg32itpQmEFDmoQF/UdvvYgMHUbJSEBRMfp
 l9jA3EQOTSL2LH+SHLdrD3oO6456jrpy0tvY6ZBPKpYQu3TmtfVR7YcQ193ZFfxdTxiWcegcHhD
 px
X-Received: by 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id
 5a478bee46e88-386b7d2aba6mr4555365eec.34.1795524441014; 
 Tue, 24 Nov 2026 04:47:21 -0800 (PST)
X-Received: by 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id
 5a478bee46e88-386b7d2aba6mr4555342eec.34.1795524440228; 
 Tue, 24 Nov 2026 04:47:20 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm39935434eec.8.2026.11.24.04.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:47:19 -0800 (PST)
Date: Tue, 24 Nov 2026 18:17:15 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
Subject: Re: [PATCH v3 4/9] media: iris: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261124124715.ickywmxur7c5bmrv@hu-mojha-hyd.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-5-mukesh.ojha@oss.qualcomm.com>
 <sashiko-outbox-219163@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-219163@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0OSBTYWx0ZWRfX2uQyKDyqKK/R
 Zzhpl3wcUFoW9WkyDzdlIiE4jyhhPAf2M7Atb+XmENK8+L5IOJTXuXM6x3d7AbXIEtNmpGRi92o
 ldhntxPUvp6YYcgRS0vgczBv1lUG3hE=
X-Proofpoint-ORIG-GUID: 3dkunNCt1ggvBIwW4tbrtATr7wIHLVZX
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b058759 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=vQny4cqFthsH--JnnNkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0OSBTYWx0ZWRfX+NfNlmGK90jE
 5zVRfsAY1uxgvVGqWd8/FKHtMlaLPJnAs+qt00Oqtu2wSTHVdKibwMpH/le77mT+ex2kJO9PVWf
 9HH64EfeSroq4odk59rK3XtA4CJEIvKgO17kU8bObso5fi54lGENO16HnWnF/J1JhLs9FJ4lMYh
 cG2rPmuWD4GXd61dCeON4oQW5JsRTIgT2L9Kpc3sUkKc1IL07GlSXSAg9Bd1AOnnIdo0bvpGWEC
 VimI11gGp54dAd6GvfyAAhFXjZR+OFPYy8zrJVlLbd13dtPyBR3Ma37KQNJNI04XDfY0Fk9/Q5j
 VRdQA+wz1wyU4PNae/bCoPrvb+sVaIFNj7a3cUxPZ12x8kMEnLDPf9cGoGghv9rq6lD214RdkFN
 xMVSG649HjSA+JD2CmBYYQjaR4rYuw5X6auccKOVJ21Dpv4ZtDbwNNCwkbHBkC9DfFRt3YM9OHW
 sHkiMDG8yosEX5yznDg==
X-Proofpoint-GUID: 3dkunNCt1ggvBIwW4tbrtATr7wIHLVZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
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

On Tue, Nov 17, 2026 at 04:24:10PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] media: iris: missing qcom_pas_metadata_release() in
>   iris_fw_load()
> - [Medium] media: iris: unzeroed carveout memory scanned by
>   iris_detect_firmware()
> - [Low] media: iris: missing kernel-doc entry for pas_ctx in struct
>   iris_core
> --
> 
> commit 06c574841baf80a5b2f096e918c8cad3e79ad9f0
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> media: iris: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit embeds a struct qcom_pas_context in struct iris_core and
> migrates Iris firmware loading from qcom_mdt_load() and
> qcom_pas_auth_and_reset() to qcom_mdt_pas_load() and
> qcom_pas_prepare_and_auth_reset().
> 
> > diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> > index 3e4cf652bf39a..ac73bda072f85 100644
> > --- a/drivers/media/platform/qcom/iris/iris_core.h
> > +++ b/drivers/media/platform/qcom/iris/iris_core.h
> [ ... ]
> > @@ -129,6 +130,7 @@ struct iris_core {
> >  	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
> >  	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
> >  	struct dma_iova_state			*iova_state;
> > +	struct qcom_pas_context			pas_ctx;
> >  };
> 
> [Severity: Low]
> struct iris_core has a kernel-doc comment block describing its members, so
> adding pas_ctx without an @pas_ctx entry will trigger a kernel-doc warning.

Ack.

> 
> > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > index 21f57d37da187..b701a7f43514b 100644
> > --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> > +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> > @@ -201,21 +201,20 @@ static int iris_load_fw_to_memory(struct iris_core *core)
> >  		goto err_release_fw;
> >  	}
> >  
> > -	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
> > -	if (!mem_virt) {
> > -		ret = -ENOMEM;
> > -		goto err_release_fw;
> > -	}
> > -
> > -	memset(mem_virt, 0, res_size);
> > -
> > -	ret = qcom_mdt_load(dev, firmware, fw_name,
> > -			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
> > +	qcom_pas_context_init(&core->pas_ctx, dev, IRIS_PAS_ID, mem_phys,
> > +			      res_size);
> > +
> > +	ret = qcom_mdt_pas_load(&core->pas_ctx, firmware, fw_name, NULL);
> > +	if (!ret) {
> > +		mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
> > +		if (!mem_virt) {
> > +			ret = -ENOMEM;
> > +			goto err_release_fw;
> > +		}
> >  
> > -	if (!ret)
> >  		iris_detect_firmware(core, fw_name, mem_virt, res_size, desc);
> > -
> > -	memunmap(mem_virt);
> > +		memunmap(mem_virt);
> > +	}
> 
> [Severity: Medium]
> Can removing memset(mem_virt, 0, res_size) cause iris_detect_firmware() to
> scan uninitialized carveout memory?
> 
> qcom_mdt_pas_load() -> qcom_mdt_load_no_init() only populates individual
> PT_LOAD segments and their BSS tails, leaving inter-segment gaps and the
> trailing [fw_size, res_size) region untouched.  When iris_detect_firmware()
> subsequently scans all res_size bytes via iris_detect_gen2_from_fwdata() on
> a dual-generation platform with a firmware-name override, stale data in the
> unwritten carveout (for example after a warm reboot or prior Gen2 load) can
> cause a smaller Gen1 firmware image to be misclassified as Gen2.
> 

I could restore it, if it is required.


> [ ... ]
> 
> > @@ -233,7 +232,7 @@ int iris_fw_load(struct iris_core *core)
> >  		return ret;
> >  	}
> >  
> > -	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
> > +	ret = qcom_pas_prepare_and_auth_reset(&core->pas_ctx);
> >  	if (ret)  {
> >  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
> >  		return ret;
> 
> [Severity: High]
> As reported by Konrad Dybcio on v1 [1], does this leak the PAS metadata
> buffer stored in core->pas_ctx.ptr?
> 
> Unlike qcom_mdt_load(), which passes a NULL context to
> __qcom_mdt_pas_init(), qcom_mdt_pas_load() passes &core->pas_ctx to
> qcom_pas_init_image(), which retains the allocated DMA or TEE metadata
> buffer in core->pas_ctx.ptr:
> 
> drivers/firmware/qcom/qcom_scm.c:qcom_scm_pas_init_image() {
> 	...
> 	if (ret < 0 || !ctx) {
> 		dma_free_coherent(dev, size, mdata_buf, mdata_phys);
> 	} else if (ctx) {
> 		ctx->ptr = mdata_buf;
> 		ctx->phys = mdata_phys;
> 		ctx->size = size;
> 	}
> 	...
> }
> 
> Neither qcom_pas_prepare_and_auth_reset() nor iris_firmware.c calls
> qcom_pas_metadata_release(&core->pas_ctx), so the metadata buffer is leaked
> on every firmware load (and overwritten when qcom_pas_context_init() zeroes
> core->pas_ctx on subsequent loads or error recovery).
> 

There is no more leakage as it is using stack variable and
qcom_pas_metadata_release() call happen internal to
qcom_mdt_pas_load(). So, no issue.



> [1] https://lore.kernel.org/r/ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com?part=4

-- 
-Mukesh Ojha
