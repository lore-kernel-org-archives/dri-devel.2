Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA44606A330
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FFYXB7KP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hQj0xSjJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2035112963;
	Fri, 27 Nov 2026 09:59:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89C7112963
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:58:52 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7Gjix2421573
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sqHlpnv9nCaWc5k/N6xeMuJ92Th9JTg9I+6KoCRS8CE=; b=FFYXB7KP8bTOV2BX
 lHqDSuLFy+ONvVxACTAfcO0CcPvghrqu7cQvU0hJAHg9izRSew5SHNQzgloU1tOt
 2ejmJYmLrByKMWSeaxUw4wR3RQHQMp7S03a0/34G+21mydxjgBKrsnjX1dMNjNU3
 mqqU1wfcLhX04/++MpJqONfGqLjQ9h0L7MhCyGqQZIxnugM7FEDhjmAhaWKEdsen
 DFNQB62BMjlqxaMO0Twx9+7tQGgx27NVUPqSuPBGfdKWc0BgsVJE7DxEeN0ZgGXE
 rUWTKabL5d9fZLwjmLDdh3lOqu1DZcML+B/hh+ynKod/01PQDsT7K7vVmGntxHzz
 VU42bw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf92xxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:58:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdec55db650so578720a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795773532; x=1796378332;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sqHlpnv9nCaWc5k/N6xeMuJ92Th9JTg9I+6KoCRS8CE=;
 b=hQj0xSjJUK+1V5raY20bOb8Psv1rYkYsGU3eEjY7O+hlPd05IL2OLQP59/rpr8I0WB
 wTJ5ngQ/A4QGeckU/aW7arGKXkHdvmzLo+ch0bs5tqBnZfvxf7uuk3951rBfjvZ4vbte
 a5mfrqdBzWfs4WAJrfpfxY4FYR3DBGgxUHMlqQ/UuEbrC03j1D5K1xoyKVrrqzc6QzTz
 PR6yfIo9jr2pyZPYtA4ckKLj/FX8moct1Dz249Uygc4/1PSfkM75TOPpvPQuqfSrIV8A
 k2YEoW//sHglf9aKS0NeGMlaMvtwCwWLIWsOr/3V9ZYdaQkrJx6Qz6Y0qL8gLdvAp5c0
 UZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795773532; x=1796378332;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sqHlpnv9nCaWc5k/N6xeMuJ92Th9JTg9I+6KoCRS8CE=;
 b=Koc494rr5l/rmkvQCQ5PKSGmvTkVPvGFyBStttMLxNlvg/M43gqVD+c3AYbvCFmnHa
 ns6rf2Fp1ua48BOPUDCUT/bUQ/BGHSBSfSd/W3CeAmcX+T1Gcwyi1vRCfvKxRUQo/W+U
 lRfHACvMGHUEe23/Pfvit4MTl8rkkeRl1MDNgbrSm7pRH7O5BC0s15vacrzRAVDsrtil
 WeD/TNaopZhNuRDRgKSD9LJZfz0uig1kaBzRdHmLMqK2PkUCz0xVal0bt2avIk210Lrq
 uHXK7MGcScyEl/LyEiG/aFIQh4048EjYtm66wuhHaodDcMrJLUcv76Jr++/Yt7ILeRcM
 6p5A==
X-Forwarded-Encrypted: i=1;
 AL+hErG0c528fHgqw1Gh5HD3a8LdJgZJbDOrzfqlPN8lVjSqwsVXpfRtYXEBwqbutBMJ25kudf1uohn6i6o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Mo5asK2n3z5BCIcY9KlgIZTxxOh5ji5kbAB+odA5qUghvvH+D
 AgRhOx6GK9xOFjZzCIFa0Kja8CrbjNdHiTq/uqR+Bth4knaaPTWGhADF9NOZq6xTqIvXYGxGP42
 gZ/+zfZrzHAV1Pm6YJJ0gEVs8jXI9CdaaO6cJ6Mjm55lmfzUULQVcrqjBUHyd/iwKfZWKO4I=
X-Gm-Gg: AZFdTZcbtu0Jt15+G0ihzIwrAPtPF7ci5BssU9Jp2f7MVu0XT4pdEhOlt8CTVpJ+uFF
 dLSIP+M2Qz2mIp7SrTBlCkcC8/QMncWJbNGL3Dd66H4Bc9buk5ZA8fr6yH6ZIXW0iJYOwDkNkcQ
 9OBEhcYYXRKRvtPivB8cGdK/UwlKK0lPAZETwGHQtd1i/wDLF/Lk4IU8uz+oSVWVynyyEmWXjOA
 s9rAur8iZ84Lb17KVrwG8SwkyZNrz96i5qaaj3zLRQiEtHrySnbbkt0qiLPzeVowGzPV+z31342
 QQX6+HYgwWc781PY/Jau9aHEJxDGN/n2lG351+krUFibueGviJ2h/BVStctjKLXAgf6maofjHUN
 sMVDtgvPGPBWn4UatHbHckFk1xB9eIlxSK4hgh7Ua8r+k333fI/kUavkKEf5n9ZGCsuFM5TKaKP
 Kzh/Av
X-Received: by 2002:a17:90a:e7d0:b0:3ab:e588:c275 with SMTP id
 98e67ed59e1d1-3b41c8d4881mr20897575a91.20.1795773531601; 
 Fri, 27 Nov 2026 01:58:51 -0800 (PST)
X-Received: by 2002:a17:90a:e7d0:b0:3ab:e588:c275 with SMTP id
 98e67ed59e1d1-3b41c8d4881mr20897555a91.20.1795773531067; 
 Fri, 27 Nov 2026 01:58:51 -0800 (PST)
Received: from [10.204.101.118] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b4afeaaa84sm21547994a91.10.2026.11.27.01.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 01:58:50 -0800 (PST)
Message-ID: <8ec59e5f-c476-4721-91f7-7fd3fd1018f2@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:28:39 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-6-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
In-Reply-To: <20261116162148.2864501-6-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0UKa_QR9smoGAdvlUi28031tu_uN8LVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX6A4nY9I1PWcD
 z02rTzMAPXgt38JaP7qyu8hWA/bqAJw4D034xfUCVxm7yr9A1uddd5wCanE4Zpd1SD2/9/WnK/U
 EXGdvxqr0/H1NK8kZnlOsJogMq5DwdKd3tv46aQPEdZk356OXb/6qANFiHTdEhNpj0eUReqKzYS
 KCTfAiY5+Ac4OKYtI1LvWINXN+DTAfFxOzE4UhMb6ioTTaDbipFf1K4ffyfiIEWNrOl1XqNeo98
 3HuQkAMxCSNWvB+WVBwzxWeIqm/XiCTnGpOa17tdlgSPF0flVV1VbSdenfRwI6iRDaxAwlArQd1
 RSZVNQQLoAVAp2zkF0ROLqi3Go8EMc5BfoysZJuh2e1Lg4mbC2leAgjNlFuCKf6TgPG+mned43K
 JkLBVh3f/1UajDEiazgQjXB1LfOVbDryPgXBqVrLPs5Dw7LzcMZ7DxCBo2U2iEzY1GcvaoKKh1S
 mzyuEAg6Ri9BnxQ7abQ==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b09545c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=qTQABE6tYUUe6KctvrYA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX7NSdtYRrFcJm
 m5oXX1FMlcPyAFrIkhQ5VasoVp8QDtaO48yhhTSkgg6+ISpAHyl/4IoLcsC2zNTLgOOZWtoS3eJ
 wo/8q5V7ddRWdZ5IqsxzNDcQ+dkXn6Y=
X-Proofpoint-GUID: 0UKa_QR9smoGAdvlUi28031tu_uN8LVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270039
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/2026 9:51 PM, Mukesh Ojha wrote:
> venus_load_fw() calls qcom_mdt_load(), which bundles metadata
> initialization, memory setup, and segment loading into a single API that
> does not expose a PAS context. venus_boot() calls qcom_pas_auth_and_reset()
> for TrustZone authentication, which is the intended behaviour. However, a
> new qcom_mdt_pas_load() has recently been introduced that works with a PAS
> context and can handle everything qcom_mdt_load() provides, along with
> additional functionality such as shmbridge creation and retrieving memory
> from the shmbridge buffer when the same remote processor needs to run while
> Linux runs at EL2.
> 
> Embed a struct qcom_pas_context in struct video_firmware and initialize
> it with qcom_pas_context_init() inside venus_load_fw() on each call.
> Replace qcom_mdt_load() with qcom_mdt_pas_load() for the TZ path and
> replace qcom_pas_auth_and_reset() with qcom_pas_prepare_and_auth_reset().
> The non-TZ path retains its memremap()/qcom_mdt_load_no_init()/memunmap()
> sequence since qcom_mdt_load_no_init() requires a caller-supplied mapping.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/venus/core.h     |  2 ++
>  drivers/media/platform/qcom/venus/firmware.c | 29 ++++++++++----------
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 93fa77f05834..84a0d4a8426c 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -10,6 +10,7 @@
>  #include <linux/bitops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/list.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <media/videobuf2-v4l2.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> @@ -228,6 +229,7 @@ struct venus_core {
>  		size_t mapped_mem_size;
>  		phys_addr_t mem_phys;
>  		size_t mem_size;
> +		struct qcom_pas_context pas_ctx;
>  	} fw;
>  	struct mutex lock;
>  	struct list_head instances;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3a38ff985822..704343e241dc 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -117,21 +117,22 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  		goto err_release_fw;
>  	}
>  
> -	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> -	if (!mem_va) {
> -		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
> -		ret = -ENOMEM;
> -		goto err_release_fw;
> -	}
> -
> -	if (core->use_tz)
> -		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> -				    mem_va, *mem_phys, *mem_size, NULL);
> -	else
> +	if (core->use_tz) {
> +		qcom_pas_context_init(&core->fw.pas_ctx, dev, VENUS_PAS_ID,
> +				      *mem_phys, *mem_size);
> +		ret = qcom_mdt_pas_load(&core->fw.pas_ctx, mdt, fwname, NULL);
> +	} else {
> +		mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> +		if (!mem_va) {
> +			dev_err(dev, "unable to map memory region %pa size %#zx\n",
> +				mem_phys, *mem_size);
> +			ret = -ENOMEM;
> +			goto err_release_fw;
> +		}
>  		ret = qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
>  					    *mem_phys, *mem_size, NULL);
> -
> -	memunmap(mem_va);
> +		memunmap(mem_va);
> +	}
>  err_release_fw:
>  	release_firmware(mdt);
>  	return ret;
> @@ -237,7 +238,7 @@ int venus_boot(struct venus_core *core)
>  	core->fw.mem_phys = mem_phys;
>  
>  	if (core->use_tz)
> -		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_prepare_and_auth_reset(&core->fw.pas_ctx);
>  	else
>  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>  

Thanks for addressing the earlier comments.

Reviewed-by: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
