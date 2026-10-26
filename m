Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53101606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EY8DQQiu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DzkExMdt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B278310ED2F;
	Mon, 26 Oct 2026 09:42:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EBFA10ED2F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:42:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aSN62222560
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0GCwWFlC5mwyxuD52EKhsC/tATLlio6h2M9vOXP4oJU=; b=EY8DQQiuujcIHHAN
 DjSAAdIRKxtBM1vFoPiw9TVlhAlk/BxbatLkUMu2bM7kVMk9fwia2kv/O3enEThf
 cBL8PzWZ/O3r8LrTCzEpYXxi9uHSxtXiYiSnTPkYCoarrog0ZSBgk753Zs4xRAbr
 qsYvbtx/tFpVA/vg0ztq+nhud1PDb3uN1IREQCyoqBN5KfVjFF3XKGTL27L9Q/Gn
 yhVlR8pHHlAjh6jGsKATx8pSurkmFsdFo4dmo46aIM9nCrImZlmCfuBJqrOQxjIK
 ouKu/A1BdiRpMR5x14nDzCpi5Fs5dpNsajOw3rnY78tfvhnJW+rggokAhn7Q490J
 hMURQw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9gx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:42:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-536708d1a3eso11949841cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007755; x=1793612555;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0GCwWFlC5mwyxuD52EKhsC/tATLlio6h2M9vOXP4oJU=;
 b=DzkExMdtvd6tajhhnX9rQiVVgQkB1srv5sgmP9l2ShMVyb9y97hKjRFQHSVa8iY4uR
 lHbsCw355oSESeVZrRVy1nhhJmt6oSA4oNcs9Bx8EeCm+d6rN1JVsJCrr2wr8E37KNPN
 tfztRB785Nzu+cai+7Qsk3T0x61fuQE8hLG26x1sBtatylubn31rRW8diYJ+VzVtesd5
 6CVTnRDRCVe634pKwkYMwndK1DeDN0fl5m4dBb2U31dzW/RekkKMNypc2N7WFf0z+5ze
 ENPdcJZWUbdqQrA+XsQtywmQluCyMV2vPfxZ72MvBCKD9q5Wc4d+Bxa4vFutGTj8oub8
 5krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007755; x=1793612555;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0GCwWFlC5mwyxuD52EKhsC/tATLlio6h2M9vOXP4oJU=;
 b=VJkIBblyhLgB2BnsiWfqM6SIV2G6/LcE6WWjok+CNkP2E4HaXYHJB90BOIqrZdqjvF
 jXl5QazEJpi9rpBHLENuqNn8q3l0CEcZzW+WcvuY8koL+eR9T/gdrJ/U72H13LGS3zb4
 AeqBEXkFgqYCWkZ8yDSGg0Hr2rTWbtSidZ1SxGLAztwei2qdTMitfwqW2QMAkCwVOC7W
 dbcwnFhhLtK5F8WbB0zRvjuxIISxpa9GGk3W/AEqpYotNXFkWBJNO5KCmGrQeGCTq8wt
 ohrnqTUGcfEx4oEE4C4n6S6WdZOkAL/I6U9m3uqOCYAFTMMDcOeuC1oHVFJgjsj4CSPj
 3Kjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgIXBvLIqlrSfN4+GtWMLw44683ShZeXgEuenTvOitgzvpTNdRc+Jd71+flBn9UrDB864+xcZ0Ziw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJH31GVh/duHpQDJdwSSi4XU6nMxHpxKmmYwz7/bK3ZbQAOUNNo
 jgx9uKgr05yLpV/OlNzURosX10Cp8jtGLw0gD0SHSwy78OZM84JuBKI1tBNqhXYzhz6prNnWt2Q
 dGuld7HbovLZFE3b60zUbc31AMFRS1aiGiy6ZDW78dzd6wFNYiAX2apW3kzdvQlP2x876GCo=
X-Gm-Gg: AYBFou2YVHMjlDa1Uky8h+S2PCwSl8l05kBZQP0Z5BDTS81ePEeo9s4RuEHx4DtRIvO
 K373/C1CYcU62BVfJELD+TzjxdQSAKFbl8z559tP86ZdzEmRYJZ7PVOozOdTg3quFxqEqq0g9G3
 q1kWwnR0rtNzyJGq8UTyzlDE9D091xmp+lyt4bzrp8gLIiFAAQ7MaPvPRZLPGlwV/9BydpX0M2O
 k6IOyDw18dqdVR1/NQ/QOlV+FK89CVJHMH+6E1HDIFzXpDCf/VR3lMDkeN9t8qB1yLZpnJxDMm3
 gNaHPfC2AhrokvYAk0Qfm20iLIL6N9yBxvXfFcHwJKlvtA+SdgUxZLQrOFV7olx9JY3xyFaN54T
 JdDUjCbg9HZ1uH+lkozYjeA==
X-Received: by 2002:a05:620a:a881:10b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-940ef79d4e1mr938539185a.1.1793007755291; 
 Mon, 26 Oct 2026 02:42:35 -0700 (PDT)
X-Received: by 2002:a05:620a:a881:10b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-940ef79d4e1mr938537585a.1.1793007754867; 
 Mon, 26 Oct 2026 02:42:34 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea3aesm303000866b.26.2026.10.26.02.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:42:33 -0700 (PDT)
Message-ID: <e41b7af4-42af-497c-8ee7-666fef354306@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:42:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] drm/msm: tear down only a successfully
 initialised KMS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-10-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-10-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dGT4TsfbjZv09QB4W3PIqItJgAzgOGtf
X-Proofpoint-GUID: dGT4TsfbjZv09QB4W3PIqItJgAzgOGtf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX3sSXeVw6Vk6b
 6DrUZ5/mq7qHkaZTlqhQyxF9W3zxXXmIHw0h+EZ7cbRsob09HLEFQ5R4/CCROSdJ/cLVYC7ApZX
 5ITCdTVlDUkoOkQNKCBX7tHvOymbYW5sULJKIq4n3c5XsESp0MZjl8ghHCHvAEejTJ1pgTpIHLK
 93yWg3iyivRpctFmZjbuazYOHx4WJyBn/smbcUS+SGN72owiTU0XSOHF+Q1u5D+LuqH1pZshoNp
 eWxQ2XxnkxW+kNNt3TQiGsxgOfi8Jum6wn37eeqeaY57pmmVZDNRrdazXk9IDhmUa2vPtCgbNcA
 kwWYVjTOAbA6JKizNFXrT8gOKJ+uIVLflv6QR3sBkpvtDy3iBRLnuilM84GXTFpA+ODh8Kmj/7q
 4GGOKc60iJ60vpvokxxN84JDs+lu42S+B6pvjDSIv/zF3ABYV0nIx44dy3r2MZj0XDVwJr2pfqR
 5DJUvfoMgF4hU+k+VEg==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf208b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-n9uno-3Oat8RTozT6UA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfXy8cMDR0L2Lhw
 kujnOuFt1G2IK5zwS6T4gcC9hN4C95sX/7Fmw2jwUgfk+ybKVRBLw1QeohRXbIKyhj+dbUbdTJ/
 6pp01hSBod3GivKMzyZpAbBk/BsVc2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
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
> All the kms drivers now undo their own failures in kms_init() and have
> folded their hardware setup into it.
> 
> Drop ->hw_init(), call ->destroy() only for a KMS which was initialised
> successfully, and remove the flag which let the drivers opt in to that
> one at a time, as well as the handling of a half torn down KMS in
> msm_kms_destroy().
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
