Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E40606A32E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XMOhonFV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E6Ql8NhH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7468D10ED3C;
	Mon, 26 Oct 2026 09:44:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8881A10ED31
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:44:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b4NZ2806445
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mhl0TRrPmEw3OGZE76My/tb+55cAaHaJ5x+X7Z5JALU=; b=XMOhonFVX7ScY582
 xjnv0tMljWEL1QoQPCYubLs7jtwXz34/1RaHk38yw0W50a/qZ+a45yqXeeHHIQyQ
 YQTBkJbCTmnvldsM+3kZhICnglxghiTPSOOyh1ACpL3ofk1RBF7HeuR1F248lZOy
 LeBWB+cQgLMWx87ob+4gie8CIWoybncMIm+9azR52JOIzxMfGgXpsWpSoMxm9e5L
 iraXlyxkJFjd8zxnEQ8QF6e2opa8/K07rqKB/WxPwiIgcSZyCQ/MX7PxwGOHOvQy
 hUJdnQ/DXFQaixUsJQkdcXpsi5WQEjb06AFOixm6mlPdz+1GfQySxi/1QLoAMJn7
 2fvqWA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xnu17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:44:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1440e081so35690285a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007850; x=1793612650;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mhl0TRrPmEw3OGZE76My/tb+55cAaHaJ5x+X7Z5JALU=;
 b=E6Ql8NhHaKvvEtu9TdZgbTm988g69gFyOIRI3dehdn11zQcUhZQIsbapeWKotfbYmN
 tWUZ2iAmW+zZC1kSCsSDA4Z/qbQR5czIbh+bccVxqqJ6wnwbesBBlFUfR16O7s06BrD4
 2lgLYk1hyvuKI4LmMglnUKFolpukRRmzsUIyzSmmsT2oqO9hrtQVUpNt8px2L8tUT8K6
 Yj+Kxg3RoLUCrZcPCJmWvsvWBEo3BmG2h1evFGCX6qn/s5HBCcAC+B2pqp8n+GcBbyt2
 TCaYfH5bseoKG6BubKNGbJJ2P81vB64fhfA7lxMybCxXvg3nsN/gphIjO9lWUTFPNUaS
 tOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007850; x=1793612650;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mhl0TRrPmEw3OGZE76My/tb+55cAaHaJ5x+X7Z5JALU=;
 b=0uSI3cFaz8T5oCwTQRHC7kx5DAy36fhSnvLp5JGBB7w2L47Lh6QtNeZtPKMBbHILw0
 iEToX0Q39C8L4jGmPzeA7MaY0tPt/yX6G8VgefqkgIvOK/Uyu8gB9xmEp4MpZ9AEnSRU
 KsRUkaVYC6FZPLP4rHcVaOUvQaShQtwqh50Ui4fdeQn2uValwGinv82fMj6RGPXef+JH
 xxG1CizxzCucmMLYU4f3TjRn79QhdAGjBdX9Rq4Dyu9eFgU/ZJxPtDwQzQFWuaSAz+2i
 hSUGM7lXpcHEcgp23Uave/+PS2uQx9eVgoQHn+SNy65p1A8cVdpxwVItJiJFFO4jB0my
 AVkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzr68f8erFfBtUs1znoEzIWzsI9KgxZwojbWy9yB5Rb5OkZDyRxROUuJredNqoFXzLx4re7XAoetJI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYImhhbjcjn7TFFEwlD8Bx+TLAW5gQpg8/1908NdTBo6GINGs9pg
 fSeg/YW1Cvvgr88++RbOdsU42Zvg4jrcr9CD1joB91FmbkxwyP6DzCeZ94vhHKwED3qzTJFXTLM
 minPm05WZXYMNNpB/B+ZJpeiaVBWy/fkgujWvsnE++nJYjCXM6fwhkbRW/y6aM2QEqG3Zy98=
X-Gm-Gg: AYBFou1bA5cskCc3EsZVqE+aXzc5OgmqRm5SQWZ2bhfpc5p40IHZR6fN3ZhnkZVNCF7
 cTDSpJrT70M3/EwQ5fnu6gXlErRnZqivNlBx9qR499ivQEEkhB/W7XJNgSeXMR84mVhRFKDPtb0
 v8nW09gZ/u+p12AZgAQ9rypZ2uIXlfqgQPaqddE2UiaZf6SHc98mc63tkN1Gd7JEvSVb+/gF9S+
 qIyhkI+bWvG3xizu6vVMr2wFO5w6QC0jg+YH5uL33mAjPlTsELFa4whAJ9bWAhA/IqChwnUKUPO
 x9D12SOUDAkbXMmsei2J6LZZLR3RoKChAzM0pzaPAkCm0P8jHM2tdO2ngTNKZtO+JZ/RQgdkFLJ
 Y7quCxdHxPrQsjEK7xOVzgQ==
X-Received: by 2002:a05:620a:3bcd:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-940ef96e36amr1004499385a.6.1793007849811; 
 Mon, 26 Oct 2026 02:44:09 -0700 (PDT)
X-Received: by 2002:a05:620a:3bcd:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-940ef96e36amr1004496885a.6.1793007849219; 
 Mon, 26 Oct 2026 02:44:09 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b445984b61sm3532927a12.25.2026.10.26.02.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:44:08 -0700 (PDT)
Message-ID: <fa95ecee-e6e3-46da-abc3-a9e0e6be24dc@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:44:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] drm/msm/dpu: unwind a failed dpu_kms_hw_init()
 step by step
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-12-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-12-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xpBghc9V4xVM3OUQ8CrRb9pnxwMSPQ1x
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adf20ea cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=f5Fz61LfwqCCiFe2G2kA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX+Vk7KZPztA52
 4vrNmgK+YI/ggrd+00ua716P/PCLgwSbDKQB5ZgATSeJNSQbcgdH8Dj8QbR/P1HmA0IXpn8p3n8
 ccyIPoKMXf6FC9+O07UOlU4kzbzkVos=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX08tGUNyOAmNN
 pSkbQ0tHpr7prWhpMz9IIOP5+WUneR2XF5n7ArFTRsI4+/wCiO+DTowIlojJdJxICyj7+LpiaLa
 p/Wde6WlbA/eVmyQ8UzrP63yK3yL+KOclRzTbRL3MAcNv6K7OvAJUKhmpLMDml4PjRJdlKkrVOw
 cIdWZXd5Z4bDYFmGdjZh+AR7OPqDbgMX48votMIfMt0OxWKD+TU6CLECkSipSe0mPcdW/5yUGAI
 dJVe7PXYb/xoT8YIDqjnmns6n76DgNeibQ2RuhQDwo+h+ltgdX8d20Ezipi7wYa1SG7od8o941r
 JJ7njX9zg3dVSQMqFlvnVYqs8rKke1JrrEJICDO+My1QPC8NfP+puTHRyHzTbLcx60umTvRe0vk
 whxrMNQcwpvkXLPinymQvJhcKzxnGoTVvBYzBFCkbqYd8C/xhDJ1nFeub3b1tbQqZ59G5V4E9WI
 Q0sZPCAf+3aXYPnO8jw==
X-Proofpoint-ORIG-GUID: xpBghc9V4xVM3OUQ8CrRb9pnxwMSPQ1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
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
> When dpu_kms_hw_init() fails it calls _dpu_kms_hw_destroy(), the teardown
> of a fully initialised KMS, whatever step it failed at.
> 
> Undo only the steps which have completed, in the reverse order, as the
> kernel convention wants.
> 
> The hw_mdp, hw_vbif and hw_intr blocks are allocated with drmm and go
> away with the DRM device, while dpu_kms stays around for the next bind
> attempt, so clear the pointers to them as _dpu_kms_hw_destroy() did.
> Otherwise dpu_runtime_resume() of the next bind attempt passes the stale
> hw_vbif to dpu_vbif_init_memtypes() before dpu_kms_hw_init() sets it.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

LLM is slightly curious about not clearing dpu_kms->catalog but
I think it's fine

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
