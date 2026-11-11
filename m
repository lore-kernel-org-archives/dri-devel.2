Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BB0606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=moXvA8H/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cCrWTSyS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B4810F97B;
	Wed, 11 Nov 2026 08:38:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FF010F97F
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:38:04 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KE4a863510
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gw5+l/0X8hCUV3pAatH+kYAoIZTakO9BDt3Xr52dR7I=; b=moXvA8H/k0DpUIk4
 lY9w/LdPlAq7sEgrI3Bg+iQMIbcqWwsIi7En6h0dWGcJ2wgIUmRWR9DqciOLeb9f
 3E4rtwvhCyBMp4XGLLSAtNQQgZj9MBsMVgXZURvzkD9A4dAfy47xPfP05yMHXc6n
 pNBuZngbFXr9ZgcXlLw6Fr6CPZZKS/2SFXNh+zo6L5foTdkrnTHPN6/DDLFB0yaX
 JGzH7c/jq6gDnFcZUzEg3FESgXR0wJlIt7o/5u19B+TNP4qpuxYtchW/DBiRfuqq
 Hk93+AafEtpisLIAsq9N2Mv1TzsxfCv0NK53xgo4ZCm7m4WfLQh7QJjRslA+kTZe
 UASsEw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawh9qx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:38:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5035639eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794386283; x=1794991083;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gw5+l/0X8hCUV3pAatH+kYAoIZTakO9BDt3Xr52dR7I=;
 b=cCrWTSyS0CQdoNAFpmAd5mak/X+XlBSOQA6fByApIEpShG91YEZDVnc8MbxyddPWRE
 Z9OaCNhgdh2+MF3MKUkuJLmcysPJMFbDy2RoDjlbbHx8cbOYpFnOI7ziP9Pq8ngLUZcK
 4FBegpLj+Fnin0pLpF98u7NRAoL0Ueyb0VX06qQ5e3M4pgwmf/pUuwya5DpDV3nb94ky
 80efhpvU6chjn//JINht/E76PktAUbwQxh3BOIIND2v5PjHFSpHaHwsE+hs9GvL6Z+50
 Vp3u2OxCocfuNB0zeuhNCZ8UFC97WC/67V8ZiejVfROEqAXraN87WGdEPLVhewq+vWHv
 lEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386283; x=1794991083;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gw5+l/0X8hCUV3pAatH+kYAoIZTakO9BDt3Xr52dR7I=;
 b=cImwurPSnaK0eclr1G2AiP30giMJcIM9eMJA0xORxIZ1ci9gnMpfehP0QpeZSHds7v
 qWTQzgo5OV3P2XIwDZQRIUkOw9/iyipdE6Tfrcf5k4D/6pLW7EwIuyhDJHRa8uJQtxg3
 CJvT3sU9eHcYPbUPd9Rtew20jNl/xKLvB0PK0RB3VlwdpxBR2HlQRa43cMfe9i7q+C/p
 ctS0QAaBCAnf6yyA/NZzMrCI6rXQqBp9Zxyel3MyiI5Pcd859LIn7uHRB/6SyuSTBLhZ
 kMHcSuUYicJK/xL0WYD4z0pAUAUifWu1jY80RKem9u5opD2r46p05JXUtSTVu4cOyj99
 ypdw==
X-Forwarded-Encrypted: i=1;
 AL+hErFXz6Fp+yksjIKNackIaWYHu5arEMP3vRV2yR2fqN3GHV3LQkI03005tgit7pHJ5eaRCZGBEuxTj7k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ODsUBPTezcKZ2rhx+f0AMuerMzdmox/PG7RHyV7pGMuGox/c1
 qCsFYif7y0PPzxuhLFMVrAeI5Olf/sThXqTDSSbbSPba27EomuoY6mOro2YhK0uRj7hEdHU1Mp8
 5WcH+AbKSiVc/zoct2+z8l8f8otx14Q8DyOEg3XOaECQCbvYsjNCvhnTZPSinD3Tu6ebOfkU=
X-Gm-Gg: AYBFou0iTlYEIJAoOtiVZsjWsGEyvwprmuC9N+f4+KjnAXtbPiFVf63I0ru0uM222W5
 F5W4f2FJqfU6CCCfmAChZ0j2W5m1Jwqez1CUtkbd6cOiILOuPr0Lx4/+HEw2PsXr96waYqc3Jx8
 guDJU6kVh1QgUMsNmxhTZqpLftqeq5Rgk819a/lNpmJso3l7E3gS2QAgSsc8gwAlONRUdRT7FtO
 H9Su82Qp3W9dXVKtNTW2AAqIgklWsdB70Oyliga208vXLbr2X2gB++XMy6JVPsLo7uLg4JY04dC
 1DsZTFyHw/A4ctojM9BVzWBkqLlYoAhDDalrhW6bzQwE3QwZziB1YE5qRNT8BwNo7WfvCHoY9hu
 6Naj0FDHYDx0xJT6t51B91inQ0gKNJ7xv84DY/1V9J84RvuRNVpiFqGClxdkT5j5XJrqnqX7Q0H
 Aicg==
X-Received: by 2002:a05:7300:f54b:b0:36c:a42d:9bc9 with SMTP id
 5a478bee46e88-37685c7a866mr2252081eec.25.1794386282883; 
 Wed, 11 Nov 2026 00:38:02 -0800 (PST)
X-Received: by 2002:a05:7300:f54b:b0:36c:a42d:9bc9 with SMTP id
 5a478bee46e88-37685c7a866mr2252038eec.25.1794386282338; 
 Wed, 11 Nov 2026 00:38:02 -0800 (PST)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe306e3sm14512824eec.7.2026.11.11.00.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 00:38:01 -0800 (PST)
Message-ID: <f915ffa9-e094-4ee8-84f6-ecac642fea1a@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:07:51 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/25] accel/qda: Add DSP process creation and release
 to the legacy shim
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Srinivas Kandagatla
 <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, rob.clark@oss.qualcomm.com, jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-16-88f2f24a5f0b@qti.qualcomm.com>
 <f030a190-0cd9-4f6d-9a71-ab08dd760a02@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <f030a190-0cd9-4f6d-9a71-ab08dd760a02@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX7LCeNcwfrIQ8
 xKOtzr33801S83RR2kPXtYxeJaVXz9CwVNcQoJ1BolmLHqwW+we42jNvCrv4HIOQQ+KZWgCWpIv
 sxPZs1VAOjD4wzmk+fIL8yEXoqxxCto=
X-Proofpoint-ORIG-GUID: GTVjKSIALn0J6sAxNMzy89cYv2QZxkKy
X-Proofpoint-GUID: GTVjKSIALn0J6sAxNMzy89cYv2QZxkKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX1W9W3+LrDHJj
 YoHUp+J/feXmWjJf6AeuEsOgpNyOzugSY7cYpvyUjFpHWqp75E9Kk5365cOowsV0q8J+xNXqYfh
 KCkhMiu9m3ijd0sPF8H62znNJXhJjM3vmDhG3BZ4iTbRhin352UkK8ixqjhicUdp5Wjr+DqgCcK
 yBIFfsQE1RIw6PbJs2fuUQiNmljHN8CWJDDxT6FNzmBMRohQ9jS8Daj1uu4tEWzYm6LPoUOOzKf
 bbu6Eonqb8IAjgwJu4TeIliOO+MmtDHAcwLUodG0Y/UDgDE+REs2/84DfBOEhZSPN7A5XZiDjpu
 qoqeLr6wjMzFoPvq2+pGwaAbNHzCbCmlWo957rfxBdhJgs7lqIOUIAy6ana8BMyaH3Jk/hagmk5
 pGd+tH3kFBo4E//cf01Dui3aiaKuEVjerYTKQ9YNNs807ostr1fHUTabi9frw0VClq72NdynzIp
 xpj+LwM1JJYV2JnXsag==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af4296b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=_9VnGE74eSGUFLHFbeEA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110034
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02-11-2026 14:17, Krzysztof Kozlowski wrote:
> On 01/11/2026 23:21, Ekansh Gupta wrote:
>>  	snode->sdev = sdev;
>> +	snode->secure = secure;
>>  	snode->miscdev.minor = MISC_DYNAMIC_MINOR;
>>  	snode->miscdev.name = snode->name;
>>  	snode->miscdev.fops = &qda_shim_fops;
>> @@ -293,8 +346,6 @@ static int qda_shim_probe(struct auxiliary_device *auxdev,
>>  			  const struct auxiliary_device_id *id)
>>  {
>>  	struct qda_dev *qdev = dev_get_platdata(&auxdev->dev);
>> -	bool secure_channel = !of_property_read_bool(qdev->dev->of_node,
>> -						     "qcom,non-secure-domain");
> 
> You just added these lines two patches earlier.
> 
> You are adding COMPLETELY new driver, so adding completely new code and
> then removing it is confusing. It means you added something which was
> not needed.
I'll restructure this properly.

> 
> 
> Best regards,
> Krzysztof

