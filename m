Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE7606A336
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OMuC6mMG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rf8kDf0p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6856B10ED1C;
	Mon, 26 Oct 2026 09:30:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0909310ED15
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:30:18 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4bKRW2255639
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mIZQSiSpM/e7488u2Fdp6mOIGOxn9HRZ2vmfwI5LSlk=; b=OMuC6mMGZ/5wxg4a
 iTRvasDq9tw2WzKpZwL8FKWExYiDgDrxkkB1QTQkiym0z/u3voPeDBVyU+pBgG9v
 1hLEMhrgG64Z6Qvif2hf2FxYkm7TYEbb8ezRZBABF9ax9y1ZZ+i+LCfuChBdmmcI
 UyG0OL+Zmf6SXBlOzeflnUWLkWN3Ca18v+ylo4htEA2zes65XwLwMUaBa0onnT1y
 iPbzbLNg5Vev2XTe68GuDNt+UfRJZTKgmT0gbMlsHF76wTLUqntzoOEuHQ/mJsyL
 jm/rMStB4JlyYH7JTP4rmlDhY4i5t9WDg+4o+XXoA/KI7VnGVHIOMhFqK3muLOkZ
 Ustdxg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3nnu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:30:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93df7a9466bso28133785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007016; x=1793611816;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mIZQSiSpM/e7488u2Fdp6mOIGOxn9HRZ2vmfwI5LSlk=;
 b=Rf8kDf0pUozB9/nOINdd8op0j4rWFpg4ExizHKoiG2ubJWu4TGhzxtc71zTxFvoswx
 4PzDQoLd7AsqIXHREs+j2np/bjvlBqYRIKi1Y+5WiByxg/EFm3Bu5Ed+uoNKm8TSw1wT
 11KW2PLkLNVoN5oqhNb9mzH0WYx5g5LeNrtbjNZ/ryVG5DeDGuC9hqdWuiIn+/aytob/
 iqtIo8zd5TqWZAa2ii7o4PlrRDtOw7boeJaYr/oSdQ9dv44/KkqLeVWkn0Q+c0ryqGxM
 oex4LyzdOPAjYNGkiJ0qBCFwVo3g+xnBXaLkswG6hgb+3i3hDu6Xi6X8WOj8g32HSqyK
 FDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007016; x=1793611816;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mIZQSiSpM/e7488u2Fdp6mOIGOxn9HRZ2vmfwI5LSlk=;
 b=oz/EF7VuZbdQ73bRkHdVHuFoA3IcdCXDm+RM40tAMCj2WSvgd13w78S9boY08lTvTd
 /A1ne70I++yC4X3QZSvl8Z8s4zVXhhask17RsJGUonCzL4j3FnoiYwM2WxvOwYhm/dKR
 MsTBr5xYHvT+s0/m7ZSnYOh39noFndBSHRHQsy12+BrIgdFaT0aVQ/p1PfDkrVJJWx1Q
 dhyRvJ4qlKzcHEmk4e+BxjLMfhf8i05jYtB3UT7ZxjHwhha+LOplBgMo9CLMa1shI3+k
 GXSOCAMh6dyhIIuCxZJAXlJ0x9vX4QlPPQLaMs+LABLO+Xu9g8uPLRKf73H3hFX8i82y
 L1tg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJWqeHeE8hrV+qAI9ixHoFMVItn/z8BWf0+stQqR37ow1owJTNi5C71qsK6PvnR3UX1UMTp/+nQvo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI4CV5ws0BjuFDB1Z0kuEOFhFMTcgXlmFZRBCXFMORhUbJaTkr7
 BbYhndzc55dlUtKygLXaF1UmZRQ23UBTikARqpK/oit5vW6HwGh04jkKqn3vITbU5NSFLoTf2JH
 bXkcqkdhfVb9c0uklLRnkEuofxWvWOfRvi4JSP8FfxzCXQdkqVAWlZ2jHWET8SpL3WWBnuv8=
X-Gm-Gg: AYBFou1z7uybOPraMSx57R55hvSkW6DlBiURX/DPIOI+MWeybfqDB6VzbAdLzE7MR4R
 rKymyYiZnNtSjGfHHxdJrMYmmNicby1LqoC+YGc27gy9tLlcpCi6qP4+1W3YeI8PCKZ/bkFx5ea
 lOGG+dXDnaEO5tnaFR/GW7QETjs9AfLUkDLq9gyGS6/PtThlwxs8NSGitP+qcI6GZc8wFOXVD5x
 Vt0OwW62ujJ42iWVyDNncYpXwqsy6rULBGRq/dvPocZuQOHCUAhf8cC4Tmd2Xr0kO3tTkJtLHzm
 qt4SexKWEH2oHlI1xdavo8/fwzxLcXxDf9U/YTfdcqaoqAV0ERTLJKWE9+cJD/AE722nMiAlQlw
 NfmtwwCWvYJFmdok5852p0g==
X-Received: by 2002:a05:620a:3a46:b0:939:8bc:8826 with SMTP id
 af79cd13be357-940ef81ea60mr928440685a.2.1793007016442; 
 Mon, 26 Oct 2026 02:30:16 -0700 (PDT)
X-Received: by 2002:a05:620a:3a46:b0:939:8bc:8826 with SMTP id
 af79cd13be357-940ef81ea60mr928437485a.2.1793007015951; 
 Mon, 26 Oct 2026 02:30:15 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4998f79fcfsm40784166b.39.2026.10.26.02.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:30:14 -0700 (PDT)
Message-ID: <b3a3e3fc-1cfd-46e5-8474-e74b9b331075@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:30:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] drm/msm: clean up after a failed msm_kms_init()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-5-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-5-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Vv90GEJie6vlVFDFYyo-E3_0n5lFQbMC
X-Proofpoint-ORIG-GUID: Vv90GEJie6vlVFDFYyo-E3_0n5lFQbMC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX2ebwm7Z59qbf
 tpMXRLOkCXN/LUVdwNghMSy73FAnR0oIGXICPvZ/8BVvzaVhf1M9RoxXZDhkF44/29QprOu4Y8T
 r6NIlcSEw+L+yaYLcydKycMOvJtECcw=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adf1da9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=aNtMi0Rn-IhE4xeoyWcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX6gqUWOqYR63p
 s7wFR2KifpbBjlRcPqG20P/rVDv+6YE3InRnHjTdBS+9deVkxnKeGtWIlfNl6zlE2qiiEQeexUd
 jf78zx1Fm6xy/FOrIQo13I2tbx+9Qdy037c09QSiJZkInwJWzXna94HfFRCpgJTJLMV0pdHihZT
 QESYSphYoiNOyfZDu6LuXl4pXyebedMbEQM+Tr8uXUngMfqXUQJgURv+E1RVw95K9z6GK9wW975
 U/o+y1M0slGF7MOOecfVN1yb8reyvUjiXyr7dgv6w961+5C2XI/D68RoXArSye5NMS+CQRDMae4
 aKcTN8sqbZiRPUL6mQ89MWmXKrJYxVUi/AGWFtshbql2Z/wi+jB+sijflKek7oxVbtPXxXuKcly
 4dfTo1BANEhW1UdJdxxCVLmlWYhXxAt2cA7mM3IKZ/PBiedUBWyBXbz+rq9bCABqFjq2SH8gyQX
 QlxCAc2M8kokFIzrDAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260037
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:19 AM, Dmitry Baryshkov wrote:
> msm_kms_init() returns early when it fails to allocate its workqueue or
> to create one of the pending timer workers, leaving behind whatever it
> has already set up. The kms drivers' ->destroy() callbacks still run in
> that case and reach msm_kms_destroy(), which passes a workqueue that was
> never allocated straight to destroy_workqueue().
> 
> Tear down the timers and the workqueue created so far when
> msm_kms_init() fails. Until every kms driver has stopped relying on
> ->destroy() to clean up a failed init, let msm_kms_destroy() skip what
> has already been destroyed.
> 
> Fixes: a409b78fcdf7 ("drm/msm: move wq handling to KMS code")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
