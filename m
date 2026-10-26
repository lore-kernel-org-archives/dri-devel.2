Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF767606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h6Y0oEWA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RzVI8EZD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5780810ED09;
	Mon, 26 Oct 2026 09:21:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D5910ED0D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:11 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4abFc2222724
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JYl7nG9VCZ7POIwjt2f7CoGn454MZk1gl17DIn6O5n8=; b=h6Y0oEWA0ENairNF
 O1YRQJwuTXnKRSqGAu4ITnPg5XNsSEgeBHRCuP8GxMUL0vikQ8kCgR0ntF6Imybj
 oNrLvXThJt6y1gbvrB3uqu5Q1rvYyorZkSL0bFIQs1kXR6IGJOKv7D+bGYUFYgZ3
 Jeq2hgPafQaLfS/Wz4kvEMqNNwgO8xBSCe9jWhidUdueJDzTzZ3HULwfBYaNjHf4
 PkYL6iTf4G7rvwzs4Jr8b8/MjEKO1x3eVJhz34fiWxMA2fHdKhYVfnlhw6EjkJPf
 Lz5pPO4pjIryofSl6wX3ZqsGDtaZzkMeuxMTwcJkD+6U6cax9BgtQitN1GdK+7IM
 WeJ0Qw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9ecw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93df7a9466bso28047085a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006470; x=1793611270;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JYl7nG9VCZ7POIwjt2f7CoGn454MZk1gl17DIn6O5n8=;
 b=RzVI8EZDy0XxRl2I4q41FKAPXZPdzOXUw+NAwcJm39z7cUJ+ejrj2haF5rVW0Vje3r
 TaHnnEavBvlsnnMLrj3W6xr5oyc1gWppbf3YhlzONcNCcb4E7PcciNgVxLR6xlt36GHd
 EoV1eRr4Ahpf5hpMFsdA2iQM9I2R+j7gZ8tmKfLfbCBfqPnVEh7i6DdWheDby+yqH5XN
 GmN809uYbIerjtw3ICR3uDWgqbe4W+EGMvTvbyXAs1q+IAdaMBOP2X1MIr9YVXQ72Kwm
 CL7JvOUKGqs1khp/c8olPCSoTKMsGh1euCfbrfYCswNYyczrk5e88Bbc/R7yqOIFAl27
 xZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006470; x=1793611270;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JYl7nG9VCZ7POIwjt2f7CoGn454MZk1gl17DIn6O5n8=;
 b=kIZ6KgZcPD7wPIY2+D51jKypB1l2prbmNgvuVau5WkoX6FfO1lNuADCsfG00e1aGrY
 kKseUuMfwH57tPoXYEUo4SEXenLnFuuyt+eKKHQsMHOp0/6LirajcsM3WU8VoJYsG2YW
 MWlsiDfq4ZMLbVQHGQuWg25eoDdCoeRGwIlJeuYlJtfseN+bcCsxS3CWi7fsyj8eWPSf
 lD4WTjSbYav4sXxI3C8E86CxBH3+ElK1IsPWhDY/DMmM26IsN6ajk1gybiEEQmNq382y
 hqh8w4mSTjCwghJz9qY7u0ertJ3W9AIBfQsrHS6B65q89Qrmw4Pt1UUiyY72r7Th6NIK
 24DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeN0lvAqLSLcbWwXYgME5Eom8HatGghnrSAzMPGsFvknkgVFr4dbL6ueaQnkSgQb/WQLLFfUbLXJc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJhEP1qmJ0q2INMdopaG/GRzTnrMbfdx2mVwCWIKcm8Z0WfnL1w
 /JVbKbcEtxTvhGV928+cJHAwo0sJgtt3J8ATRqtVBRp57BmG5EcuL2kGzcLxpwKe4gK3/BvAfmf
 3TFCoZUcXPVMhcNO4rFM2vkyNDfRlZmeXb1L8tPAzqkZNg5bUia4cXBWReOnJbQ+M38vqVvg=
X-Gm-Gg: AYBFou2e2xgZ0+EdaBBZOVsSg6OIksxHOHqVfm7uprydH2ZuNFBuUKmFtpFEl+qVZeT
 iYsf7ipNMfy3OV93mLQSN/owaKb7luCLUPsCokjt83EWc0qpp5yHwc91HNSNk7uVFOHM73tf/l2
 b9cXrlyEj++39bXP683OYfM+h9LZKY/fO4VZ0mOId2oUv44IM2kgrYs8y9CCMqEg2XRV9rM9L6J
 BexujFwgcbl9yfDjjHyXIo7wX9gM+jilPqkcC9wFWGWbVVO4MmzicthRAdjofzBV4lClwlgjdJu
 mogfRMTBb9jG8MfwAlsxNn0+PByB0apj4/OjkGwqADejGlHCjnq8TksnzxWZye/Lh36VGu98WuX
 P5f3q2NLHvPSowtjdzezDjQ==
X-Received: by 2002:a05:620a:8703:10b0:93a:14c:329c with SMTP id
 af79cd13be357-940ef7c179dmr952636585a.1.1793006470016; 
 Mon, 26 Oct 2026 02:21:10 -0700 (PDT)
X-Received: by 2002:a05:620a:8703:10b0:93a:14c:329c with SMTP id
 af79cd13be357-940ef7c179dmr952634785a.1.1793006469588; 
 Mon, 26 Oct 2026 02:21:09 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd34fbe6sm294029966b.10.2026.10.26.02.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:21:08 -0700 (PDT)
Message-ID: <f932be26-d911-4c77-b958-353001929692@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:21:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] drm/msm: fail the snapshot init when its worker
 cannot be created
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-1-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-1-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aP0QM2cT15gPaN3MudhxJlIOTn-3EyI5
X-Proofpoint-GUID: aP0QM2cT15gPaN3MudhxJlIOTn-3EyI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX/PjH0EQ+bU4U
 bS/I+vGScXUHPjdgRbMG1We5d9hCtzZT8gyL2/n0o4QhJVOhf+X5ul8wR/LvYxF1TPrn4HwS01V
 Afac/YlhntWbX0Zgnr6Hk9jdtONCAADzQu3hPEbgzOhimoqqDljtRC80iciMJjUevTPUBbxddth
 0AxpqKhalDi4Uq9HYfpKVlEknJsps+1F+nfz8wiyP9UJEgXa2uO8DJctl0N4cRmxFWByBTqfNWT
 VpJnqYa1Gk6Kr/OuN4yUAIxiqiyAGYOsr4shPiAwHm7ITeOtueT2su4tzjxJ13dLwHQJ0svtaRV
 Mvp8OoxSMTdoAoMCSbREkme1Ghly7auIbOX+7GRcg8Ml3SZdReZ2EkOzCjgHzPPKyiY2IPWQDr2
 FPrIqRVqOroxVyC1j4fbD9oXBawcjzL78SSZf6VKEtaWgidOhOsJZpZv6Oq6Oxyr7SdLz3owJCg
 QxX2E8u7JwNo8to4Oew==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf1b86 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=O4p-ns5tyOGKaCv9pfgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfXwEgPlwpakKqP
 //gFQjirPjWWFp+XvtwEwcxHqKf8kaU8EmMjkhXe/OiYSxoCNnMizj5qZlFt73lk26yGUO7YB/M
 +TdRziXgw8j/enaO9+qm/LShaK/eQkU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:19 AM, Dmitry Baryshkov wrote:
> msm_disp_snapshot_init() only logs a failure of kthread_run_worker() and
> returns success, leaving the error pointer in kms->dump_worker.  Both of
> its users then dereference it: msm_disp_snapshot_state() queues the dump
> work on it on the first display error, and msm_disp_snapshot_destroy()
> only checks the pointer for NULL before passing it to
> kthread_destroy_worker().
> 
> Clear the pointer and return the error instead, so that the KMS init
> fails rather than leaving a snapshot facility which crashes when used.
> 
> Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> index d99771684728..d1b10656e41a 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> @@ -98,6 +98,7 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
>  {
>  	struct msm_drm_private *priv;
>  	struct msm_kms *kms;
> +	int ret;
>  
>  	if (!drm_dev) {
>  		DRM_ERROR("invalid params\n");
> @@ -110,12 +111,21 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
>  	mutex_init(&kms->dump_mutex);
>  
>  	kms->dump_worker = kthread_run_worker(0, "%s", "disp_snapshot");
> -	if (IS_ERR(kms->dump_worker))
> +	if (IS_ERR(kms->dump_worker)) {
> +		ret = PTR_ERR(kms->dump_worker);
>  		DRM_ERROR("failed to create disp state task\n");
> +		goto err_destroy_mutex;
> +	}
>  
>  	kthread_init_work(&kms->dump_work, _msm_disp_snapshot_work);
>  
>  	return 0;
> +
> +err_destroy_mutex:
> +	kms->dump_worker = NULL;
> +	mutex_destroy(&kms->dump_mutex);

LLM:

The error path calls mutex_destroy(&kms->dump_mutex), but
msm_disp_snapshot_destroy() runs later on the same failure path and
destroys the mutex again. That's harmless in practice (mutex_destroy()
on an unlocked mutex is benign, and the debug checks don't fire), but
it's a redundant double destroy. A simpler version would drop the mutex
handling from the error path and let the destroy function own it

Konrad
