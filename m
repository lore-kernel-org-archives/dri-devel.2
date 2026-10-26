Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B144606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U9uvUfmA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XLe3tsiW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8619B10ED49;
	Mon, 26 Oct 2026 09:33:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C7810ED0F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:33:28 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4as243303637
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zpYg908oPalWbYc+H1dirfywabdU7/Y8XdyQuanQWwk=; b=U9uvUfmAqTvW1Kft
 zuqxAeqbtUtYq1O/K3YYH3qteNs3QjSLk0knW0j1v/4EQiV0qPXt1xrUNTqxuux7
 sBLbjgqVfP9MnfFRmaNM+UyGsOrQ8ToW25Xer2ztcNpmVR8427/kMCCcYpu3MwHB
 9TxwUkkOQ/jxuYAoPwSwdPrqBLqiGLNFQR6gTIjXfVt/by7Wiss0CEnujQqE6RrF
 V630GcmP+gMdozEAT7Ie73TZprMJUbBAhCEi3O2bxhBSsgeG4Q6g3B1LHblUv0EI
 R+G/9ca3LpPWS+fTlXrNeHxIiMnJPhiCSnxTJXdsjdqFMdwKPlmCVl5/zdRR2GMx
 nEVElA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsdstf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:33:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-533758f24f4so3707141cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007206; x=1793612006;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zpYg908oPalWbYc+H1dirfywabdU7/Y8XdyQuanQWwk=;
 b=XLe3tsiWmBso6BLX6SxqHx2LUR8KSQnRkW23+czDpAl2gJbpyoqJffjXP9kBIXDU9H
 w26k9Asoubf2u5Sf4OAC5HPyUusZcFgH8OW+v0xbddetT7CPtcY3DG8rtjxqGc4EOKY9
 PhvbjAsypqOJVDZIqISr+KDFZAz2wIX+JCazRwyTh/oovwFrNawlhrVEwjM1n7LJSe93
 4FPy/G30Po6oGAnWePsCAXzlIKFym3gugyEF2QrwcpDope2jfw3uuwBAp4FHfmFsFzsP
 mORMZDlWgmtd3fJt3NfFNDnp2q6J0QrP+IznXu56zCqHZcVdKP+74mPYiki8U8Qptazy
 B46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007206; x=1793612006;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zpYg908oPalWbYc+H1dirfywabdU7/Y8XdyQuanQWwk=;
 b=hgKo01eLIdXz1qzOlfS2CMXqdKQcso+JAWZW6M/W5+fTYQ3CR8/2Wzr5UBxeCFHQw2
 4rAWMHGEQyvD25qg4I44p2rqHBNFm8d13WDxxrvVQVRyDtulH8I/PzEpF8Ll8tt/4Etx
 xls8YuvoyJ+jQgDegcPtSOtJdJZ3egjKzbRGFwXv3VckPC5VDUNl/VW+8drgdIcDm4zi
 LnqsuOZGaEjmyYm5GnYKHcNEAM46yAbpO8IxzyDwFwtNaDBywfPM0jOV7oc36kvbfd1d
 ICphQE3aZ3p0gjlFAmmG/bxXeto78YOxV+fW6X5CY+Q3k8UciqQuopOyMfx7fwuzzpOS
 lknw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEIQgI74XGifckk0zlMO9nXxRNXM2kiOKX/RUj6E/myQGfocqG98u5KePczabLTHBojkcnqHQnmNQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJqrv+rVeHmlQbdOFnV6/BglsID+cKkXHtmcfSvPI36t7m6vs1u
 eKwAo9bsMpY0IAdzrWmLUzoUaO0eCev9MK+qSFPQ9V18bpBkvrURj28q32unEk5hpED+sUjnf1g
 IBOYH/fLG5a+bknfitAy2gf+xNA+kZdC+bC4/dkLOTpCxVMVwPONYre/4J6cBUGrjaf2UaK0=
X-Gm-Gg: AYBFou0nKT0xUzImrsCMYpKtfAGP6VZ3bzSFuTQx90ZDnZ9EAvamek2CUnbp4PUh5xY
 FIGnGPrYgIYkWTbURyUy61+SxikjKPDcrp0kIV097iS3WOxj5EPpjHfTOq1fn7LhLi77u4N1/A6
 44vq7kTNXz0K2jGKb98C8JQ7Ybo+X9um7EoYIzN5xnBzVmLRhpo3jh5E254jDA6GrxOHPIizNjQ
 aPAweAdzhnVO60j1UG97wkUkVgCXILwq+FS/I37Vai9W4fuaZkW5BTzOSnuf1XA3iYJA5ljAS5C
 C8AGFKJ7+8ycxcAdtZXmQSb0DxLViZIMpzHiScBgXMStlpGKm43VwGpVm9oFfR6Ti9Fy9Z5KEw2
 QVnB63BzJbt6dRCubBPKC8Q==
X-Received: by 2002:a05:620a:8a87:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-940ef8f51fdmr888589585a.3.1793007206490; 
 Mon, 26 Oct 2026 02:33:26 -0700 (PDT)
X-Received: by 2002:a05:620a:8a87:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-940ef8f51fdmr888586085a.3.1793007205884; 
 Mon, 26 Oct 2026 02:33:25 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd77e1e9sm297083266b.67.2026.10.26.02.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:33:24 -0700 (PDT)
Message-ID: <1ba88d77-aa7f-4038-bd56-fa6074207ffe@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:33:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] drm/msm: let the kms drivers clean up a failed
 kms_init()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-6-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-6-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: q1_8WBuxD8qxhchSrcnVUfrcfxuERAU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX+kqWVaNMk3uC
 B2J8bW/Z2qLi/nF8dypI2sRcA+wXo6406K+zZs9njyo+ZN7MmylCdsl8838/lT09VpltzQLBuQn
 2wTurWvUYn2TzLeUDV+lk62Dp8jACF9R59cPX3T/7/mH0MbIEoA45WZgbCE505wkLCeTKk9Z/4o
 iJlCGgMbcCc89KeyHj0joYwr++WVazgKAIp59DDbpuW/8oGsy/EZxuWTU56wXe97Zvqz45x3ZcQ
 01IQHnTGumY/t7P6/BAZdj7X1jJn/+Uf61Le1Ve7psWEvMG0k4DEo8HEopgFWEqe0l0hmGhdbL8
 Hlvdikinhi2XfWCCKfsjXUzkDIgHQQhEi914zfpgQJsqlIKTcPF78z5GtLFBMosNfF4idpfF1WB
 727BaVFdK7Kb2j6yhnc8JlHwNKu52cwHKyuce+p5CgiskOv7zVqhrWqLsemu8dd4M+3flnBy80P
 OhkamYH1XA06qMtAvxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX5hv8+8dlS5uF
 QaQWukXT6Sm38KPWL/T4x5PgEeetcU2hS/8xldqSNHi5Jmp5vkn091dgyKPjxCU1ePTwr38Ik3a
 emtysIndO34EfDCe903XXscEqgYMr9s=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adf1e67 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=qYfICrLDSdKvHRXiKZgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: q1_8WBuxD8qxhchSrcnVUfrcfxuERAU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260037
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:19 AM, Dmitry Baryshkov wrote:
> A failed priv->kms_init() or ->hw_init() is cleaned up by the ->destroy()
> callback, which makes ->destroy() responsible for tearing down a KMS in
> any state between "not initialised at all" and "fully initialised". The
> kernel convention is the opposite: a function which fails undoes its own
> steps, and the teardown only ever sees a fully set up object.
> 
> Let the kms drivers switch to that convention one at a time: skip
> ->destroy() after a failed kms_init() of a driver which sets
> init_unwinds, and let the drivers fold their hardware setup into
> kms_init() and drop ->hw_init(). Set up the mode config before calling
> kms_init(), so that it is already in place for the hardware setup.
> 
> While at it, tear the snapshot worker down after the KMS, in the reverse
> order of its setup. Nothing queues a snapshot until msm_drm_kms_init()
> has succeeded, so no dump can be pending when the KMS goes away.

LLM:

msm_kms_init_vm() arms the IOMMU fault handler inside kms_init, and
that handler queues dump_work, so a fault during init can queue a dump.

The patch then tears down the KMS before the snapshot worker.
kthread_destroy_worker() flushes queued work, so the pending dump would
run against a destroyed KMS. The original order, snapshot first, avoids
that. Unbind (msm_drm_kms_uninit()) keeps the original order, so the two
paths now disagree.

Konrad:

I don't think it's entirely unreasonable to get a iommu error halfway
through init

Konrad
