Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E5606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bb9PoiBq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d2lhv1T5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38566112039;
	Thu, 29 Oct 2026 07:57:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65B0112040
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:57:39 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5HHwi3829663
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9R87gYw/cy5uKWiwAMeRUbz2KigGtGCOWIclDCkHwR4=; b=Bb9PoiBqSCoRChvf
 1o890rAKaJB6cQmvACTmekSeLbSwRg9ojrrPtRQHEKwxuouNAd1IePVH3vJAbEJN
 wdw/KnxGmf9kBxNelZfBhP4sFRAwmxAN5iJNeR8iQoc6eji2FZi1Adp4V5l3J6V4
 6MkVBO6ztvLc4SFlMu7SfN8aZ36mffjZn+1aUkvA8JCYGceziBLZbUHHpTMIoLXu
 FgRTFspeyjI/e1yDvcv/86/20uSgs8NIjAn2VX9Oyit1+Ten8GSu4ucnUIpU3BXX
 21wMYCToayu0h9i4xQnoKlu8TsLis26Daudg304YsCnQpkTNsWHHRGcHwKXC7fTh
 wq8+KA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmp9k7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:57:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1f1f2ecfso42035185a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793260658; x=1793865458;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9R87gYw/cy5uKWiwAMeRUbz2KigGtGCOWIclDCkHwR4=;
 b=d2lhv1T5/8uvfpCyK1pQ1TQ+g6Nih8QlQMQCtbQfJwx/poDHlIbhpPM24hezGrojm9
 8gh9PDpC2D+/jCtVqaXJ8cZYPBugGMieokVM44H/ObBbkIm82ax7JnqmoTtA8HX/cCIq
 FjlPyMmZvcjxAyNmHQjDKd0o6bKPct+aKkloJeon9tEx3ZZNS5yBYOVn8C6vYxyedjGX
 U7snFecbL6QIH3NIYsMQVwkfdzGyBVM8hAVNj3EGc1337UfCcTZH0uIKNTbCnKmcCk52
 3dhbAuXkGrVjLF+1U2YonM+EWmFGO6kopSwdPacIZrPNDX11iM/zVZfaJMrs98DsUb6/
 4UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793260658; x=1793865458;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9R87gYw/cy5uKWiwAMeRUbz2KigGtGCOWIclDCkHwR4=;
 b=v3M/5cwqvX3m4vxigGmShWQ0tujr7K6ISqcC0Exkmihmw9j3WggFQoA020Zg/uiM2A
 74MrYCxeuqhJEBbRbKMok1uvTaHKK08l3WjQtPbsSbFwG8MtHVpXBguAEfThx8YLAelE
 i/ZCbwXjqryi6SD8NFwivGrb7jkKN+E1DXafLSN0m1uOfR0F0BCwqVcpE3KuxcHfRAOb
 t+ZSz7CFol70In7saTEdXAgJujXSJcnXzvVydMxk+yulLdFEy+BMCjoWAcmbJeO5yCZE
 uY9HAy4pY6qwKa5MMV41VfyrIBXG/CvBXYQiycSthglMPiKHizh4REg2Pi1Du6+bhFDE
 Sj2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByYtxbwxI4Iq37jDmTE0BpmfBiA9+f4WKdgnEHPInhA7NNtOM5UBG6FW6MYybAShZSy7OMji5bfoXw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKj9Bdm7SZFqYAmD00eriWbbPaBmQFzYQ0kK15qr5bO09jSoD2a
 sd6m6DkVFqPq/D+z3hyn3zL6B+H088hfzw+Uz/Te8vIgwczfNqg9QQO2icGK34P0FdSY0h0CJE7
 p/8Jhht8RjdxXokcyG8ItnEPxFJaHt+QdwX5DWrCh5935Ao+q0iIaAjhlHYp4GGKOM0TfbpU=
X-Gm-Gg: AYBFou11AvEZ8zjZJ6LE6PlzqPnujCQIYcWGg5u2xU6f+aEIN5GNBaW8TJxxkYlLbdh
 EYsgcoghihCp6OYOCK+q/vwp5oW7zsID/hqRQhdbCgkU9iXZiDXmqHkhTm6lmLsEnsttt7CcjNi
 v5lvhTOaqKWTC1/oSwSPKVbHpaxZzSbQaLWqmXdLd0dF99SS7ETpaeYTjEZkg4DoeF4/Wng1hIZ
 WX/BltdA/XZ3tDoOy2QNrKPk4PZJdQa0dMf1MG6qECrBrP0rm5IQQoISvAVdXXVcDPzS42XG/Wd
 9HAIRdmVTD917z1xTiNtajFXG+HpCnKTtwONm4MpyF6+DYflOvPjNmBJuKz0WLeR2fahEITE19z
 gsa/8Xyj4/72qIuZfmR+S86S9c68V+sbdwR9Zibn5Ptfxh8BUpYx1oJYR/3hghv1FP9BWiIs=
X-Received: by 2002:a05:620a:3bc9:b0:93a:ec4:e5f2 with SMTP id
 af79cd13be357-94408d42cd1mr780795185a.6.1793260658058; 
 Thu, 29 Oct 2026 00:57:38 -0700 (PDT)
X-Received: by 2002:a05:620a:3bc9:b0:93a:ec4:e5f2 with SMTP id
 af79cd13be357-94408d42cd1mr780790685a.6.1793260657590; 
 Thu, 29 Oct 2026 00:57:37 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650a56sm705458166b.50.2026.10.29.00.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 00:57:36 -0700 (PDT)
Message-ID: <66c299b0-d30c-47d9-a6ff-cb0c47d2d789@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 08:57:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Soften no-firmware message
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029001601.82269-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029001601.82269-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzMCBTYWx0ZWRfX6hTl+clJ1pOo
 WTsGdFiropAp0/GGVPQ8gywQ/OwJEyNVc+0+bi9CIL2scJFX8ZkRhLQjfFqYtXXKxyiou00gr8r
 py6euDWjqTpbz0j8fctzujMny5rcaARh4+RPEh4eEzO5/J/n7q5ED1oCs7/QizXgOT0vH+JErS5
 6vmFtV4tKvleW/isa78lTl1DXrkkSdd3ec1NdJ2+usqPZddGVtkbC6v7+5/6FPaUpsUOIfF4Tfi
 WFwGV8/9CKz+1L2fgErtJyMgknUrEWOw6slX22AwJZfPro/bmZuOqT7R5MPt0bsZzE67FrywCj3
 kanHqRwXxYalFN62nLcIGw/Pxx+MebDl6Dwa/cxhZkGdQTUknZcCa9fUSCcxXlqyXxy1OjLlBZR
 NBQnUc551EONbk5SM42D9bQXgWBy9xAB+ke9vu++dol2lxPiaJHwktrXn/dM4+MIy5/pzt3VQLV
 IsKPBIHEqMgQVRUBgFw==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae2fc72 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=MTgaiBtVHodLpOmOn-4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzMCBTYWx0ZWRfX+uIZFC+bP2PL
 57LJ3xnKMu7DSSVHJ1tfS/r/tdwz+ZQILae6a0XSTInG4D9e0gjQJ5S+p92TUK6+Tz0WyebUjDU
 J/aLbmVTpPcILj/vtvCj44Dp4eios78=
X-Proofpoint-GUID: 8HPL5ULiWdPJBJyFmehsjzZh_wha6sZC
X-Proofpoint-ORIG-GUID: 8HPL5ULiWdPJBJyFmehsjzZh_wha6sZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290030
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

On 10/29/26 1:16 AM, Rob Clark wrote:
> It isn't _necessarily_ an error, the driver will try again each time the
> device file is opened.  But if you don't have GPU fw in the initrd, you
> end up seeing this error message at least once.  Which seems to confuse
> users.  So try to re-word it slightly.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
