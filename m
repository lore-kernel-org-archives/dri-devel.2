Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD6606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=juhMW/ei;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cZ89r8y0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD8D810E485;
	Thu, 29 Oct 2026 21:24:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5DF10E3C2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJk0ii1708345
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Kvbi14Ro2Jet/rtwBr/WGcCUE+sLT8/ztxk
 oluFqXzQ=; b=juhMW/ei599lYu0rJJYdPUNl7t3bA3+SKsV6j+954pbIu9Kj8eo
 Ciq6ohXOGQyAPNBqf8lCxt/sacTHwRTKTNXkZNYYxoLNqGU2wXydcw5IfxE5okHQ
 i0TPywtx/1Xb68BcgkEK5yA2AI8qMzmx3aumAVh3Z4wkXXMP+rGEg/KRsidyTFft
 Fcf6UooKpooD7wFPR0cEkiJSd6y+Tpgk+1c4eIaCGIjQvtiHKrBTDCo90B6F+YqG
 UoolplzT5fO0tfB6L7v4GIwI+yMuu6X54xZvT22B6coCxhlq7x0INmtrxg9y9NB/
 gIQ54PYY1jalU8w/LKiZtcQlO0pu+2snuTA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76ckd5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so34411a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793309029; x=1793913829;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kvbi14Ro2Jet/rtwBr/WGcCUE+sLT8/ztxkoluFqXzQ=;
 b=cZ89r8y0QZQe2g+w2FW+i3qY4LbMOrOIU4xTcV5vsO4ad8vRajV9vwohALvXVgqgkm
 OPMr8nm+BFwy+I/58vMFphOBf969j3rEaxsXOH5xSI9yII+w5+CIVTsOb3kZOGq0vhsd
 jGP6duOXbvN1GrqepehOmP8hufWhFeaWTzYXT9nrVDFw+PG8lncTj9P6hVY47TvLTOTW
 N7vSJ0KGyZNSHPOWqUGE6U+Tn517Vc1HgRwSDkJSo+17HZA+bbujuA2G8e28kiuJIP2b
 LTeD7nAGCKzFe5mkvVWzFqImuJRYRzv943WmlPDwgT0bnOQ2UowUbQtm/wl7q6ljSRKN
 vw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793309029; x=1793913829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kvbi14Ro2Jet/rtwBr/WGcCUE+sLT8/ztxkoluFqXzQ=;
 b=YrxPUPkuC+316tOVgDxT26K6srtXTtJgJVSxk4iz4wmjHOCdcTFTPI0eRbcEYX6BY6
 j+6FfI+pcC0SeUpah9zz2JMKMvRyuqAah1qsKZOr3FxE2A4V/8+FTtF0eKLCHQh3mXrQ
 zyUG4JzStRwpKHjc76JXCXplsf10wxhXZyd/UtNYvC+00Lqpr/GqoHe0mskdaQS/Jjm/
 Jlov23rYmqoobEJJ70ChRx2uzkB9U+F6sirYVjk5nM9VRJN0zefStlZNTWAJXOX0VNPy
 wtf5HRC63caUhZ+2/hnRvKc3b0p7fFHBoBFkaIQt1kcFyHdsZDsaSoz3M9azaA0a9+cg
 Rspw==
X-Gm-Message-State: AFq9FYLztMKMp29liHJlGxvgxqOMA7Mt/ZCA/gdOAbzF/caYNVm78r5k
 uoh1nRvUCF3g8cjwwMHHesvxUGjfSLITR9oUweMwuj54QR3Eyh+kc0km2K8ZMENXw++yJHvR1o7
 0ckQanoel1nvNpzo2AFjMYBHqOLcgUrvE8Jj9nF47YUKo8KtNMItqNtN6DTtaowXXHlkly6I=
X-Gm-Gg: AYBFou1EICJHOnkx8/x8lYoAfhlPCeYP0ba8T18eg5AMPmrwTfmXjqolCO8DlmZkSX0
 paNdSPbhuy1Cdb7VsU7cnK1vdTHDiB9P1hPTqveBgbNyhS9lBVN+7xDxQ2GssDv4dvF0VEzk2Dx
 Ddahg4guUagYCQe7O3avXWHS7bh7XRVVNmFBTjUtegZZ4DJGnd2rEe/ILA5dq9O+9e6UAs/PRq4
 BTI6iZRVm+KmBpd8Cf2jW3Fv9Pt0T1w2v9stQNKu0Kx8QRGbu1L8wufEUMUmj1a7L4DxLbSqIIZ
 Wt80S76qIdNRNWJW0dLdrbVsyvedTLwdd3nYGltkXWtutpoMT325yzL2uvGWWlbZQ0R1o/6YRyy
 sKPURyymWnhWcmS1bNMhTPuQfqa7k5JJNmn+L0gFb4Ox1JrjDwMX1EFbFBGHgFq6B5ajcj1mWTq
 LN0EdA2oI56UuiXWRq+x7zlg==
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id
 98e67ed59e1d1-3ae8981e41fmr175460a91.37.1793309028757; 
 Thu, 29 Oct 2026 14:23:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id
 98e67ed59e1d1-3ae8981e41fmr175434a91.37.1793309028255; 
 Thu, 29 Oct 2026 14:23:48 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e99b267sm5559785a91.14.2026.10.29.14.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 14:23:47 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] iommu/qcom+msm: Use identity domain for display/GPU
Date: Thu, 29 Oct 2026 14:23:41 -0700
Message-ID: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jMSHAB9J0yd3crNahLq4ab6WtizgQZI7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX6GtqWG1uFnBD
 3bG4PkoAH0YorvIT+cL2bxiLsg1OcH/kUJV/MEIVlMvOTxDNcCMJwU2KQygQjzzTZAy+RAli9xC
 7jqaIka3ESVdeioiA+h0KlAVFQ9SK2e1ZoKCI6LGvalDjV+dnDnPFULLc+pLYfaTyBtLTCj6xiS
 C2CFVJUiJFv2G2MKkzKYA4k8FWx2KYd1P4sxm+XnRR29uQDsT3mK/CdCa+g9QFrQiYrCCwW7vMQ
 6IVFxBrm3MhYv0b7Bt8xZ7dEEwbrUxQV1wkAG0eTQNUkJk7xw02ISX7HvVb5KUZKr9Iv290BdqX
 MK4JvePIN+Ea8YFNI6h4mBbZ8ASEXL8S/dtspxJYrUX7k8uTWO6cwWbKtG8eqVz/wHA5oeq2z6F
 B6eLzTw7JlP/uHmpM4HzhpQABz5XB7sY594l9WdfvLOf/RrizdwGqmCjW0HtV1dQOA/ipVsw1Fj
 1zVisZUpnANVgVfEFyA==
X-Proofpoint-GUID: jMSHAB9J0yd3crNahLq4ab6WtizgQZI7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX4P/LgixyM04v
 IkkepdaSQNtF+SR1nnhmAYsHRRH8aebRfokCdk4yEZYOO9nsWLFDKGRKKNftKHgsnIh7/cvmVZj
 x9cp6EMPLgpFtMsN3qnYqvgzENJVRIA=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3b965 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=wtkIETcKxqgH55doulAA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290084
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Similar to what is already done in arm-smmu-qcom, match display and GPU
compatible strings to pick identity domain type for them.

So far, we have an "evil twin" domain kicking around after drm/msm
attaches it's own domain.  Until now, that has been relatively harmless.
But it becomes a problem with [1] when we start using sg_dma_len()/
sg_dma_address() for setting up mappings.  Which is required to avoid
problems with CONFIG_DMABUF_DEBUG (dma_buf_wrap_sg_table()).

The first patch is at least compile tested.. msm_iommu seems to be
armv7-only.

If there are devices with bootloader splash, we may also need some
work on qcom_iommu_identity_attach() and/or msm_iommu_identity_attach()
to put the context bank into bypass instead of disabling it?  Not sure,
but that is probably going to require someone with such hardware at
hand.

[1] https://patchwork.freedesktop.org/series/175619/

Rob Clark (2):
  iommu/qcom: Use identity domain for GPU and display
  iommu/msm: Use identity domain for GPU and display

 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 ++++++++++++++++++
 drivers/iommu/msm_iommu.c               | 16 ++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.56.0

