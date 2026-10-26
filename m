Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A018606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CP6sGin6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MCke/s0q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177F510ED41;
	Mon, 26 Oct 2026 09:45:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6AF10ED4E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:45:12 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b1cw2206175
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lO0MFluqBf0mYNkf9/R5BtgFlYo1UJ32JSCP8hcoe5o=; b=CP6sGin675or+lEO
 X+3bMtYFNK4WKRtl+nYdBSnL9Sdad5BkSmRaERFJPOx9lcWlKONg/UKWkDr5DpGa
 C/3PBJo3k+nlFB27NduTRCnzEERKiSL6RWLK3dJP3ekqZAxSn7ZPqPSQ71pE/lma
 Aj34eLat5EdTAOqapq30V1JfWqKRtGXFCcixn0YNrzw1NekUrti7OoDzoqWG9znk
 0rtjZJuRjdlu6NOcmLpMAacRIGS2QkCI7VeKxAVZQY6j1LFhYrg2XYw7t2ngjmVt
 57u4PpCLozahYjufmlkzSDtO6gQ/KajJSEpo0k+uGYg+ZUn74q9ay5cArQJthvTN
 vi/mWg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrunrqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:45:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92eebb130dcso42745685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007911; x=1793612711;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lO0MFluqBf0mYNkf9/R5BtgFlYo1UJ32JSCP8hcoe5o=;
 b=MCke/s0qrKKMSzQyYY9plqsWvGP2MJqNfLcIGOldrI5llsa75qwU8VkRzno3Quh4sj
 Z+IO28Dn0T9ARSIixJnkO73S/DkzmsgfgXPnCdG34pYd1XyYKNErylzQu8aUIi4WSXoh
 sFncspTTjDTPNd12huPDX2qVYvzouQ19qVcf9cOQ8fo/LKX/Uo+pxvSvu1fKgGsV6lSf
 HI1O4oU+ql9IJ3Yv4hkBFe0YgsvNyq7RkOU6HiuaL0CPYkdzpm6GA+yTysDCGiFZdJst
 Iw3lF8hEi9U9DuuNUFzwkOTxZXeVTgNZib38cum2rHBP7f99DWmVGi+51Wpx3cTJONkC
 sZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007911; x=1793612711;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lO0MFluqBf0mYNkf9/R5BtgFlYo1UJ32JSCP8hcoe5o=;
 b=P1BQsg9AyOmfYZnIFKwciWSkus/Re3BnkyRb7RJr4VLKBZSaa7bLXHnYdvkENilXgi
 l1OCWJAPTyuETDuqrJb5BtQiGM1gXuG1Osa7jTwcOvEUbrmzFKlJZXhtvWEucGYVzqVo
 HwAiS4FznqhJCwwF5TYoiHwEKExYw/YBJGs6exDo3CdcQEvVEvObeD3maFVsWNPmq3K6
 rznpjUCA2Qq046rjffm6N0F7X3sdcZh6NHpRhwHzmT+Qjem7yJm9cE08h1HrMYJjsFMp
 ON8HA3jWu15nIjBsM+6yAMS8w7Fu4mP56S0RgroHbcUO5nke+RC/cyT5teQSwEKMNkYT
 Ibcg==
X-Forwarded-Encrypted: i=1;
 AKwUvByTBloojdGrs6aF4AIZ32D61gB6iDkFgI8w8WotuYn0GAVefriCMvLc/iGgDz0+zRdCpGxqlufvIGA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJ4fujb9sknZMlYa3PHDMtQE2viv+mv1d89rqLvUYkm+EQt0WC
 y1oE9+iEFolKFiUQqX5cZ2LhC6rqI93k6Q+tJG+BV3QApDZyQjj6v0riMfQ3apIBjl6Amh1ZTGq
 UvHRgvJloS3s/aQ3m2n5aQE88MIG7/ByoSV61k/IiGxwkA0nyMyUsgF26gUPGxspT3Jd58RY=
X-Gm-Gg: AYBFou2ktrGx7C9OCbcv2NaKK3plCOIsbB5Y1z1Oq5RzYMKiAJgClHbNE4F13bM5jVp
 uG5wuJh5kSnDLk8X1ctcALDpjRtnTDaJHeLdfE7zjSQOdNUtAr5eX15rfKP9h8teDX8IKqnjV+m
 7izsSQzKsRCMy+2MogO05IoAXvJB+y/XzFDjCRJZ45K8ef8hFyA+q0E2DjgkMVasO1Fkzl2xh3y
 A/esGiUNN8GHGifLksDd3k+byycPMciiDAyE1pSN+F8O2K7wyBJPtR/9vnW1t2/V+e571/SDxKr
 d2CTNb2kEYbFqL781yhb9mTBJOsDbukyFsP5sEx7k+zI4EV+Ux+/nsf/BkzRHFX39SocB6sEvk1
 lmdOrKO4ZvK4+Q5VCE9ylJg==
X-Received: by 2002:a05:620a:a181:20b0:936:2f59:dfe4 with SMTP id
 af79cd13be357-940ef67bc89mr925204585a.0.1793007910992; 
 Mon, 26 Oct 2026 02:45:10 -0700 (PDT)
X-Received: by 2002:a05:620a:a181:20b0:936:2f59:dfe4 with SMTP id
 af79cd13be357-940ef67bc89mr925201485a.0.1793007910500; 
 Mon, 26 Oct 2026 02:45:10 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd649997sm296085066b.42.2026.10.26.02.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:45:09 -0700 (PDT)
Message-ID: <f502a9c8-67d4-47a2-b855-9a6bab4356ac@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:45:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] drm/msm: drop the runtime PM flags from the KMS
 teardown
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-14-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-14-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX3InbNLhZaLcE
 LsNwZ89TTg2xMMiPcdFfPsIPWX8uMXEABVYHN/qvpQOmXkAfzJKR3u/Hkqs1BQPxzlQEY39kqS1
 KciT57KeQWNiqY+8P4hikFpahY9W+ca/taCjk6pfBRMBn+wOzvKlUePlPDnWbWvyx88x1QJMXAp
 NVxWLhdA/U+Btj/dxM29KxyPe8vWdZm+rREwAbEDMc6S878v7x+a+dfGWmeOhupyok/uTu09Wnr
 PcvYJsCqcEV92oomI9egMBx1hel6oQHQ5b7BA1nvd/wcGwLNxTA+ZfLNC9GcOuwEhGZ/FYj7MqI
 +EQOk9M6WKZnZWLIAUrXFeSiEIxtkSloOKUjyqkAUg5GypfuJSyxebnfF+gee8N2B0fy3ItcLzL
 SqpCD0xK/gFpqm4EkNCxlU89hyX7SCye8JXiBfdHYpSDzHUBCwtlEwBDdQNqvCAfcqhP+J3Egqj
 aL+/Rjo2UFgFLjuaatw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX1tKtXs3BRoQR
 m+KgJ/i4lKVUPubo5x1v+pMqq4pSsKr3vBRlEQb30FljebHsIPYLpCWN7NMozLz41ldNsMQzey7
 EvAlfIy9ULnyyqgZK1EYYuVs5iGh0EA=
X-Proofpoint-ORIG-GUID: syihVCRwG_0-6RwWSMI0ECypnvMs_tWb
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adf2127 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=PRaoJ6uHHRdXhmLcd8sA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: syihVCRwG_0-6RwWSMI0ECypnvMs_tWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260038
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
> The DPU, MDP4 and MDP5 drivers track whether they have enabled runtime PM,
> and MDP4 whether it has pinned its blank cursor, so that ->destroy() can
> tear down a KMS whose init failed half way. ->destroy() now only runs for
> a KMS which was initialised successfully, where both are always true.
> 
> Drop the flags and the checks.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
