Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BB606A331
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8zn3Xn+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZFyKLPuL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F9810EBCF;
	Fri, 13 Nov 2026 07:51:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F0C10EBCF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:51:27 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD57ZfL3616415
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zHE80jLQk70fW69I68JYDsQ3DFTnh8/DiUynz1wUO2s=; b=h8zn3Xn+xZabN1wI
 Kz6LcvdWdRWg0JOlOFhJZ0uhlEsyg5OTq1SuHV/hBEgnwSOOommJKHIapR3PRJhr
 RdiUT1nqwTG/MOEeifLme0V2V3PP5t6ByiX0XK21CYvHCpPWUktgXnFk9mQ/akz2
 sgCA7ivV2a3EcM9tbI8fhiPWp/akJdPMyRGWcytI1KwEEZ0xg368rvQC81lotaOc
 4cTQx20bAiKsK2B7WWdxj8CLdU+n4kv92T1OyAkpyZ9cWmuwVXwih7Qn3IaW8iQF
 PjuowGaHnyU2F3C8wGwUdYWFPOet69A49vMcqOhSavSLo77YiH4gcn2OKX++PPzN
 de+LnQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0ajrmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:51:26 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1a5005fd0f8so1968470c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556286; x=1795161086;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zHE80jLQk70fW69I68JYDsQ3DFTnh8/DiUynz1wUO2s=;
 b=ZFyKLPuL1dfNv3AVQjm11SA0Lb/bp6LKPMfIfdfTP0+rAslUz1F4YZGhJzPT8hSeJk
 B2yhpsTb2B/tHlyw1NV5IILG1FLL3s+UBT2WqcsTPMIoTjGm0fDyEzKqep3Vw/+l//av
 h2nC8gccDgs3wPFYxc4eMalOdHNCMvO9MV0W8LHOPDaVV63i5IGkIk5MbocxKG8RZ4Ra
 /q6THiHhnshyKbZMUuW2aHQ5bAn4z6MIIb4FxvHgqPmeHq+kcO6154G9qhu7qvGv4qXd
 PY8JdLWbESPE07Jqt+Qgo2QjDTp0xKowxKuT+kIbbi1pyWsnt2B8nq+eS3tG1OsgUmWv
 m7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556286; x=1795161086;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zHE80jLQk70fW69I68JYDsQ3DFTnh8/DiUynz1wUO2s=;
 b=0B8Mc3fFBpimNdE+X9vBA9vtWl68VEijyPl7YWIaZ+88EaoXU6fqS+TfG6fMXFwhFe
 YjjQcL2OlJqqL3ulA5kkkTCNYYHrLTTNukPRx4784LGRbi9NXfAB0nWYUMo7plJbMJx4
 7bAdlwLPGPE0/xQsNvrOL0RRBiKhJG9+GuhJ174LSOMb3NzUrEeZlGzHNbZuEWWuUwqT
 7GJjWs8VWy9Hy0AU/K1ZKK/I9FAp/ZfZ0MsawlgQ8SNBX9zHb4jwYjAXdKFr5La03KRs
 QXMyUgOF8Tydk3niBY17R4p5pqoICsBS1W4VnKsYYID662Jvjpx3m5WoqQTEp6vfRqsf
 41sA==
X-Forwarded-Encrypted: i=1;
 AL+hErH7rYOThCBSqDNts5xHBezoMpGCqMx473Z54PQp/iSK/3Z1g+1XJtWj9Yj+q0RWJkcPPuIhSwOgkEo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8wMp1KvovQwG/PQkjTg0Yha/7QlmbK+jDDFI0PO95i7wfr+XYT
 9OsWhnhgrgdYkxrwoCo5+8gNVmKnR/tnfEfWI0rp9IYYn0C16t+lMQKlF0TJTTw2CboDTINAmh8
 pWm7BHeyK8kYZctaRd6Ii+cqYiou1g0NeoVRY9YsZsfaOX8cQ2Ut2NUND2hwwIZApWhos4f3MmL
 VKkFY=
X-Gm-Gg: AYBFou1FKrH0Ta5rUiOkJqk8ToIIbOkeEkZ+UZy3yPeC+n1zayXysJAY57t4R/H3/Cr
 SZVY0N+Yr/ji5FRx+eYzFpWTCXTqsAm1Qyr4nXyfpZwhoSwjPC0k6qGD78H3KYIXWDglvVvqVhj
 HD1AdfEHG8MkkUZc/8FCmHIng63Z/iferr4hwMuh0Kfne04xSXJRd+la6qAdZJ5zuG6I1R4yDrc
 Mxrj3gePgnb6aMWXtBbizGeIkgtwl/7kwZbz6pegYD/eRv6N7toiGaSZ76rz7oHW2baGQV857S8
 xsL7zajd1+OPfLl/GAHK6G2tctoO/ynxuJ5CrlCg5/sVsSqOsoZQ+gX113/m3BbmSXQFK4qZj3+
 LEU7TL6rhBsGljkEbiiyhN6RN++70Izxme2dTu3tAfsn3XQ4v/ANxbKkiMHrGuDIfdNnphnsgmc
 Ii
X-Received: by 2002:a05:701b:4182:10b0:1b2:5128:df1b with SMTP id
 a92af1059eb24-1b5031b7dd3mr1777877c88.45.1794556285542; 
 Thu, 12 Nov 2026 23:51:25 -0800 (PST)
X-Received: by 2002:a05:701b:4182:10b0:1b2:5128:df1b with SMTP id
 a92af1059eb24-1b5031b7dd3mr1777854c88.45.1794556284807; 
 Thu, 12 Nov 2026 23:51:24 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50300e5dcsm4648172c88.0.2026.11.12.23.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:51:24 -0800 (PST)
Date: Fri, 13 Nov 2026 13:21:19 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/8] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113075119.hq4ak5njyknwno24@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
 <20260926155937.624D11F000FF@smtp.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926155937.624D11F000FF@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX1sCTo1Tqfqv8
 cpv8SJuLj4kR31QUMmH1YIHM88PGTgeBbTTdZrT4XpXZjVnGZOdQQNtLhspxG4ZSqnfXPzKibQp
 MZbeUwZWjNW2hp9uKQoAdm6PCv8zSt0=
X-Proofpoint-GUID: 9ugm1joAQVnXrUJgdtBNtCU17hxMlizF
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af6c17e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=y4KpbDpA15XCOura43EA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX9zu+HN0pt1rD
 ljkBwK4bPbybtMSeJ0B4jnHv5vSVEtBrDrcVkWYqbCo296tq/EjJid9ulC7atvtCPot70zv+bHg
 gKx++3aDd3XRysLp67cJsTVzZzDSQuGpCzZvkru/2eJaZQVRVcVE9eQpzpP4byrqzK1+XmiR0CB
 rcvjIMtXGwcaPle/UWdGVNMXS7X9JMgJPkM//akDkJDUZchmwBcDU3NkDZ9sKPTyYgs5apg+73j
 YeyPYLjcKg/n834+Zo5sO8ZqTDH7cSLi94EY1lKaXG+amIc4L4Q5Nld2AkG3ZSiWkDCjB+p35mt
 xz2D/yYkAqD66OLaiaV+9ViYD49NhwjXs5EHGdFpGEHRYytlo8JGKjHTiYJQqoMIp39iHYhRG72
 TkofrNqD6+u7MJ8doEa4Re9VG88Lr0CHnYNp7nzcBKBaa7tdprpqCf1HgoVXdRBQthNZYpwRzQN
 hr/b/i/EmDxNfJLIoMQ==
X-Proofpoint-ORIG-GUID: 9ugm1joAQVnXrUJgdtBNtCU17hxMlizF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031
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

On Sat, Sep 26, 2026 at 03:59:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] net: ipa: shmbridge setup bypassed due to uninitialized ctx->use_tzmem flag
> - [Medium] net: ipa: memory leak of PAS metadata DMA buffer due to missing qcom_pas_metadata_release()
> --
> 
> commit 5216b43b65b5b9e8f76798ae9a011c6d5ce85515
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> net: ipa: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit replaces open-coded memory mapping and firmware loading
> sequences with devm_qcom_pas_context_alloc() and qcom_mdt_pas_load().
> It then uses qcom_pas_prepare_and_auth_reset() with the goal of
> performing the shmbridge prepare step required before TrustZone
> authentication.
> 
> > diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> > index 14ac2d2faf7c2..6964395caedd9 100644
> > --- a/drivers/net/ipa/ipa_main.c
> > +++ b/drivers/net/ipa/ipa_main.c
> 
> [ ... ]
> 
> > @@ -615,24 +614,23 @@ static int ipa_firmware_load(struct device *dev)
> >  	}
> >  
> >  	phys = res.start;
> > -	size = (size_t)resource_size(&res);
> > -	virt = memremap(phys, size, MEMREMAP_WC);
> > -	if (!virt) {
> > -		dev_err(dev, "unable to remap firmware memory\n");
> > -		ret = -ENOMEM;
> > +	ctx = devm_qcom_pas_context_alloc(dev, IPA_PAS_ID, phys,
> > +					  resource_size(&res));
> > +	if (IS_ERR(ctx)) {
> > +		ret = PTR_ERR(ctx);
> >  		goto out_release_firmware;
> >  	}
> 
> [Severity: High]
> Does allocating the context here leave the use_tzmem flag implicitly
> initialized to false?


yes

> 
> The commit message states the goal is to execute the shmbridge prepare
> step. However, since devm_qcom_pas_context_alloc() allocates the context
> using devm_kzalloc(), the ctx->use_tzmem boolean defaults to false.
> 
> When qcom_pas_prepare_and_auth_reset(ctx) is called later, the backend
> evaluates this flag. If it is false, it falls back to the legacy
> authentication path and completely bypasses the intended
> qcom_tzmem_shm_bridge_create() logic.
> 
> Should ctx->use_tzmem be explicitly set to true after allocation?

Should be set only if this is supported, like KVM. Otherwise, it should
remain false for legacy support. So, it is correct behavior for
the current code.

> 
> >  
> > -	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> > +	ret = qcom_mdt_pas_load(ctx, fw, path, NULL);
> >  	if (ret) {
> >  		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> > -	} else {
> > -		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> > -		if (ret)
> > -			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> > +		goto out_release_firmware;
> >  	}
> >  
> > -	memunmap(virt);
> > +	ret = qcom_pas_prepare_and_auth_reset(ctx);
> > +	if (ret)
> > +		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> > +
> >  out_release_firmware:
> >  	release_firmware(fw);
> >  
> 
> [Severity: Medium]
> Will returning from this path leak the DMA buffer containing the firmware
> metadata?
> 
> When qcom_mdt_pas_load() is called, it triggers the allocation and mapping
> of a DMA buffer for the metadata, storing its address in ctx->ptr. While
> the context structure itself is devres-managed, the underlying PAS backend
> requires callers to explicitly free the metadata buffer.
> 
> If the function returns without calling qcom_pas_metadata_release(ctx),
> does this result in a permanent memory leak of the metadata buffer on
> every probe attempt?

It is taken care of in this commit[1], which is picked and was mentioned in
the cover letter.
[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2aa8fafc08e777e9da356307c1a0117e7f4277cf

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com?part=5

-- 
-Mukesh Ojha
