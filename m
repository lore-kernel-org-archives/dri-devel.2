Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD1606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ooOInxsA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cvOpW7zX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4968E10ED31;
	Mon, 26 Oct 2026 09:44:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E8C10ED41
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:44:35 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4arA51181762
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hKXdfB4Gw4NaKIutsMligvpwPmDeTaajtEivhe892x0=; b=ooOInxsAYZUTmA+l
 b1Lf9QSDcCoKKt8RehLUwMOId5REsiEg30o3HM2PgbLcOxdVXKJW6+RAR/foh2rB
 yqWuUEFfNmtEzXqD+6Ws8uSr616ZhYwzxAtaimbIk7Eb5gg8iTkGGGTtRboAez14
 hkYz31H2qowwoS+KbF4puBpVbD4RsU2VwcS7Q+kNROYK9mM3SXW+6WUPKN7+JOtz
 IiAO9b71Ip730jAwJzso42O1W1Z4t04aZ9lxEEHtbL9iLFUDbvjKFCfKsuQJxycv
 HSSaAPKhtffrnHRvbOJ6SuTmm2nEi0sVFTRnutmED2yzwgUg0eAosOICKXknqzzo
 1au47A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27wrxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:44:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1440e081so35696585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007874; x=1793612674;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hKXdfB4Gw4NaKIutsMligvpwPmDeTaajtEivhe892x0=;
 b=cvOpW7zXdByIIFXB6VFPRLVM5UWVe/wHKUjPiie7+wMpE7ZXY5qvNwu1A23lfSM/6w
 ECGyss0oBmUzTXO6CBEB850Lbkkm8QZ9J+JzttcrK7T3IQYa5+4Z7/jVuvDZzelePHtN
 Zgq8Nht1rdHbAFa+WiXift7R5+yMl+7FJ04+vfNzQ7o7xB9laf6zkRV2L0+mXTY0ow0D
 UQN5ibiGU9Ox+a+Tk4BTXEO0bn4IDgOwOd9PAPPxdhzsSta2xNmqmEmSrR+iHKlIKGNB
 LJMPrs8b5bYzCzABv1VdHoKjyu359JafV1SoyvyraidUqQCjdd2guOfaFuITIgAn2u3T
 f/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007874; x=1793612674;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hKXdfB4Gw4NaKIutsMligvpwPmDeTaajtEivhe892x0=;
 b=iPPttKeUMyp+V3zQHIsj05XW5Z2sIyLdzAf3RKIU2O1yzL/43UqT5++64JqyOeQ9lt
 Kyc2GkTfVztjZ/TZ/gy1WLgH05gtz/th3eWBRnFBjS5mjvYuleYG0jaeAs8/dAbC7v19
 P7HVvjx39OGSHKtGvF+1QJj6FQ2eUOUAcHwid1TvoSFLn6ph0J1gb2li/ecqn4RzkPAp
 CZIOvKpeeax0LNZTc2N9F6Pezif7AneaXKAmgIxGHJ7wtfe0LKWTNLJ5caRYBp05+oDP
 Lx0d7MKtCIgNijuKk4nN4Di3x4lrXP1BsFFh0qTAYVaM6BXGN5s/5BG9wpoB7qReIaee
 AneQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByslJVYctMGRSAwGID5+ZZWxxmbSb8q4S6F2iK5xmuSViCeVUqU5ln6O3GTLoKynMvQ4rO1htBmTtA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6b59CpA0QeR84vZcQz/UscU03hrGBLNG+wKjiyutObRTu6A9o
 kUjvX/WbB7pyOW8ArIuMSQbn3dgfoIQI2jxCiu7hiSY1GP8OzT/z1T2wA7oz/NaZJFo0evKxnJf
 ec/60RkLing4wflCfS71OJPWozsfiMCJioGgz9JBEXqrrQy11jvOancLZeLuh73ubrSzltf4=
X-Gm-Gg: AYBFou34jEzjd4cy7ukCSKpWq/smMsP7z39a/eyYQZf+oH46EFUgsIDFJ4cYERvzV26
 1HGxOMN2UH5/HqOVxq1UK/Hn4MRv1ssDQABxVhnuKOOdBRs3Iel2m815JER8use66wfK/1nE//3
 LOslSZ1oYqG1UONazpnSuwfTsV3+qOMuK6x683SBl/29IbCFniPDAA4Mk7E50f2vpHgH/tbw9Yd
 ou/+BncFhV1TOU4qm94vXwXKSCj/kEdcY46Npcz2iR56tBe5a0tP0c73IdhocEUPMjhOi0pxPcm
 4yQZ6yO7s8RVehKP5BFK7et3uYOuPf9MkfGKMtdBtKt7/GPlJpv+kDE2F7Tf1PhW7XbYxF52qG8
 hIWN3A0NV/yirBXIYKMtQfg==
X-Received: by 2002:a05:620a:3bcd:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-940ef96e36amr1004579885a.6.1793007873990; 
 Mon, 26 Oct 2026 02:44:33 -0700 (PDT)
X-Received: by 2002:a05:620a:3bcd:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-940ef96e36amr1004577485a.6.1793007873529; 
 Mon, 26 Oct 2026 02:44:33 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd34f465sm297052466b.8.2026.10.26.02.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:44:32 -0700 (PDT)
Message-ID: <40720fec-3147-40d0-bb0b-44a5a89ba0c9@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:44:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] drm/msm/mdp4: disable the vdd regulator on
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
 <20261024-msm-kms-destroy-fixes-v3-13-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-13-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adf2102 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pXRCLyShJLD6FikErHUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TQLnD4aFbwWbfJE-XSw9gGRCA8Yf7iJa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX5B2VmH4ZXgnt
 uZxA4FiEdAEpTSSNlCbATV7pipqAjgw18/0oBH3BLcx5R24tcAOo3LUMy6BPUAh8GKEtqYTk/rQ
 9myseS3cSPrvooAqG2Yif/6v1x/04E0=
X-Proofpoint-GUID: TQLnD4aFbwWbfJE-XSw9gGRCA8Yf7iJa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX6SZhC0U/mmFe
 rJejPE9yRFrC3zS2OGtfFm5KVU/JWSb+WLjJUPUb6ThioIS7jsYGxUzuvNV/77wcX0kOgZFPn7/
 bWjWl/yr4elRJ6ndkNyj9Ph2u7mFE7ZHcni28ebh4GAu/p3o7L1Q+QjhJ9kg5HCTZaPbU5ocqn8
 kqCN00hYYS1ziJ8kUdOzSdAX4SnZeifqwbFIjvvUtHnMDBDB9FbJUNOH5UCr5mv937hULLQDUYt
 finJA3ko61ppKdGhly+4E0HEd9r9h2B6wwBHNi6cTMRNvfAG7xpOpl4CQ8cp9DqPxVFMgulO4P/
 1ZccTCmwnAfFMOWoaHxJEoSMhLEXRRUmdVfXyljnXhCvFqAIhMMfjsqNBpF/0b9ZkSjEfNXbOXw
 hQXx2FzHBBMbx/v+QTsFL9TpHRxyqu9b0FF7/wBTFss5IBresPP4IPeja/3pxXUzA3Db/TbpB2q
 E/y9QygW1xhH76UIWBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260038
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
> mdp4_kms_init() enables the optional vdd regulator, but only its error
> path disables it again: unbinding the display leaves it on, and the
> regulator core warns when the devm-managed exclusive handle is released
> while enabled.
> 
> Disable it again in mdp4_destroy().
> 
> Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
