Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52745606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YFeyapOX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZmK9rUkz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF3C110E030;
	Wed, 21 Oct 2026 08:44:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E2410E030
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:43:49 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j0KY756332
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sIzv+OVRF10962nsg6GhGljzRZ3rl013V2T6GKgjf4Y=; b=YFeyapOXeANzacnB
 szxZleI6tSL08EA4Qqe6SA4H9Qdi9M3gPWiGhCerNVfs8RWmEBq6lbjmPxXbdgpG
 YSAHIYgWfJHpP36f6PsJ1rbbx6/5Ssjz0ms8xIoZXbau1+/wo42WyuoT3OjrjWP9
 9VpHnKbciMtFeGqM+2RACKtv4BO9jmVnVSdjhkFxcuaRf1QS0ZfTM2gjg+TNYI+Q
 SYFzOqqjZiLgMNMrTVj4GNLEDcnw+zD3fkJDnHTRuV4aAliTWXP8lcJEcZhTq7xJ
 yoBxyidb8SyRylC6Rv36g9SyrJyv6u+ja6894uQFNCT0djALRqrDzv9uzRq62aNx
 zjUxUA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4txyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:43:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179ef12a03so2794056d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792572228; x=1793177028;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sIzv+OVRF10962nsg6GhGljzRZ3rl013V2T6GKgjf4Y=;
 b=ZmK9rUkzzSUxSK8XhRcxE0gU/e5cUEUofczconzKvobXS+eMU7YIAnziKjuJTKUET+
 cEBF+MYYfLpgVsLvwGzAsfSr7CIyarvHMQD6U1Dx3tV/3+DQUWwm4NSa2QyW8sDgROZn
 F99DfNdgKIyN9JT9HKPCIHAAeTYQA8EC6g2O2i49wGNxv9cxwzTlsVLiz9WgwA46c36/
 ECZS4mytDlws7HOtznNU1AAtZdanIipjdwCQqqcHNAyvbrxiUvsooTlq2mpM2Z87M8af
 5TYCsejXKq6xjXafO4NRRsYp7jj7ADMFrqKHwCKS1LtftoJo1RNucoXhiJ9MgfFnVb2E
 FTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572228; x=1793177028;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sIzv+OVRF10962nsg6GhGljzRZ3rl013V2T6GKgjf4Y=;
 b=Awjm4kTmAK+FeZKWr5kzCkfWj+FvmOHb/mKMUqqyjmyiSN1XNkPhv1n0b+p6ScXYAk
 iUGEm8dPN48uV9I7t88J48r4KrgrPINViWjsY0hCcHV8E8gzBGelxoPURiRf2qdFY0Ft
 pLAKWG+aDnf4hNDs6bjE6ehzem4840cfHJ9g9P9TmiXdJpJfX5Tpg0SMGH+OWQT8Uhg/
 5x/mgghqo9Uzsjp/+V+9x+H76vndLlMmlXSlptsleTMEfdjcnpxNZs1Sx6RCshcZvGoJ
 Cl4DatqJoG7R0+YIYzY9+JTKb6Wn334h3VRLRNhVDIcU8jhgPc6Hnv4fQTXgNkgGVSbK
 pKCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsitaqt5P8/dpKoSg8teGCzNJAulaEA5j8POJRpUwdqBDobSKYiPq/l0RAQAGMFTLixzi40uRgb9c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIR40xvc7jLA07e5vI5Gc+WxgZuFOXK+lAncN7LD857PL9z1Btr
 3D7KIu7mI/MMeNxP6WX6jYwxkvGc9YLv+VK5Q1ZLbkaN/XLSckt3IMwwZIfkij32qkyYFhYBWST
 kONfgFfA8ijNxQZF494INsE2SYefLqogwxls3Y7R6Tjz8XlGdcHWx/Zu/4wgx61pdeyvF11E=
X-Gm-Gg: AYBFou21fWE+8gmJX6+Uab7NEU7umJz5xTxG82IcWpN4k1bdiC+R+Ss6ZtRmRl4xiGq
 hPJ7ynfE6ja+LJBsKn7d3lV+bxqlB7q+NTIUB6+qBihw2LJxUwsbZbyjYP5Wtrte10Bfwf2L/bZ
 bq+gNqZm9JFoJt8QsqE8tLRbcZlggmeUzQ2ZUn33ZKFY2Hj3J5gmkXhG4GNXdh9aaVssbaMUY28
 bZ2zH9mHXA3bnoQ+mqNjbjV/F5dmbUztZJuDbQMeFx7a8PQIDN8FO5pZinlLsl0bNk2cig++92T
 XLMtQd8v6Z5WwqbHMF73/G+YaLl4aml6RrWZSuWD8Hw0QqxDSXm2vob6xNrAA9bHF/N0zmqfQkn
 weLFpEC4ymXkJ7m+zPSeEbw==
X-Received: by 2002:a05:622a:a884:b0:531:2663:2cd with SMTP id
 d75a77b69052e-536a75ce176mr415931cf.1.1792572228221; 
 Wed, 21 Oct 2026 01:43:48 -0700 (PDT)
X-Received: by 2002:a05:622a:a884:b0:531:2663:2cd with SMTP id
 d75a77b69052e-536a75ce176mr415691cf.1.1792572227794; 
 Wed, 21 Oct 2026 01:43:47 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c467900686dsm52393866b.74.2026.10.21.01.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:43:46 -0700 (PDT)
Message-ID: <72009e19-fe51-4340-9378-46eedd71f151@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:43:44 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] drm/msm/a8xx: Switch to generated nonctx regs
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-11-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261020204728.28844-11-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zZ_E9JRk9lX8SzfZXt3AsqevqdVuVBym
X-Proofpoint-GUID: zZ_E9JRk9lX8SzfZXt3AsqevqdVuVBym
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXx6QYSl3AhpMk
 z0J1zruAd+pE0Oe32z70ihjeJHKv9Rw+VBSRv1BcCePYsfaUX5cIyFoGemHMDj3dunW7i63zXU8
 KZZqaGEhAbo9YsKMW5LCvk3T1FGXt1o=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad87b45 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Uo0wf__DB8OGiezfqlwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXwyMkGH7dj261
 392SzUJIbMNXlOCyL+Actlznw3Hjoc9i7JcQ553be986Ta64qkgmiAtUB3rAfSBufXeq9+iKQYa
 w9xUPp1E8MWwkOer7UK1x/9HRFAn587A4QFad9p4P5tgE/ZccqrOSqdNd30WZnNGvGmzf3kub+T
 3sxsBcp8jIivbdTG2WwbPkjTXJRcmy5RP4N5BX2o7WZedMR6by7P1I6AJ9fFa4pyEvVDrFrFWrh
 LsyVt8Vp3qjccSfVpHPcOArVRkLQVFPHskly/Dof9+UbdeiY26NsLX3wpB+6TLdQozEk1AVrf0N
 6dnbhhGlmlBSIxflDFYcINj+6rJSreBmWbauPc5W/AImQYOUIPt9P1RhcV+2Iu/NPYnPp3MLUw0
 JxMfvo1+YD1wCToJLZZNrUeJjygSgRlRNJq3LYucYSuE1w2C3SC96L4Eyrw/0Xf3Y/E0uGlsi7J
 5/5C4xCHMX4oloUhTGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210034
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

On 10/20/26 10:46 PM, Rob Clark wrote:
> The generated headers contain the current (at time of generation) hw
> recommended values.  Using these directly makes it easier to stay up
> to date.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
