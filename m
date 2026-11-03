Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F2606A339
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KHMplylt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HG4Aq1sq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E2B10F51D;
	Tue,  3 Nov 2026 11:36:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93E110F51D
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:36:29 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAFGt1476149
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 11:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rZ/601LWddKHMRgUDrwkuLM8pPkuLsinigUnQn8yf+E=; b=KHMplylt4qd2nDjQ
 XOXksdjHd5gcy0dypge2wbhnRkW9tI3lPh0gz7q+5BxoJ6tsve5QpTfz/9vsD9JG
 JDjcL9M94cWFthloiMLCzyUisqxd222ClNjt4LfOmQuEQ24YnQxR+Cij0js1F3Ll
 57pZ9QMOeZ0m9FIsuNPCE27TIF3+YypbCGnpwMVDLxrDIY2h3dPJzm2F1HDKSJx6
 /5GdyroFIOruTALi6gyGIMbJY7tDfz1qivYe0/WCo/g9ow/8OrbRSnACMVJLbnEq
 b1jJQyIYHCfidwrbh478gFQY0Tc5gbDmjiciQqFvu0ZWsQ66lVYl0h7PFZlXpBkN
 sWWHJA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq8u5hjet-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 11:36:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1440e081so71105085a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793705788; x=1794310588;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rZ/601LWddKHMRgUDrwkuLM8pPkuLsinigUnQn8yf+E=;
 b=HG4Aq1sqBnDi73xWEwmEqHA4RPkm9lAwGDxU3qwx3IEjCEpDI25L6BUdZQB3HdypXn
 e0MAeGTGr/t8SudRTt31GaMWmt9uLCjw0lnMtcdsuVkJgGzn/wG7g1UxM4Vl/FT80cEV
 FthTHEzoyNyxtfDiZpBEHHgXPiJlKXQiBxgE518uPPqwl9dxrdA28/raIf8avwwyolmx
 EU7ORm8AdlbhVq+IANHDbqSCqC16Enk8de7bcwhaHDcw/RA71kv1gxF+FhVY2tIjKrwI
 D+jyDrLbh9b02GZtbwZLIwQ0XFWtoUWEtOCbrjWKSgQODAKSFa+1hoNCQTcoWFKeOIjq
 9NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705788; x=1794310588;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rZ/601LWddKHMRgUDrwkuLM8pPkuLsinigUnQn8yf+E=;
 b=C5KWxtmJ8ZWKw2iNSnokcFMeknPDPChswWSfFQMvwY6Yxp07OLi+1znVW9KjnmgQuc
 f4hn5Whllh+sXtnoPIdaQgibEuV6mDyJAXersJuiV9//DbLnTrQ3gMnU5pF91wwUYAWl
 /m7HmZ6jQj4zJHBHHhbK0bH7hwrhDHWjwnOMWXOp0dVlbgRkzTDKFtk9uvD2OgUTc5Jv
 DVS1YWk4qCbHx2DumhYdlC6qrJTqn6DJJj+EnA2HMW+NzrXkc6W6GYUdHUf97mQPDpgU
 XTrPw98fXecByS4iTpiXMHbzu7NGgzhK4b1rpUd4RtF6QamYQat+KB8HGB8XiWIJu+qv
 QfDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8CmjtjbkuBOfdsK32nG+U/GAyqvQRuaRKo/HABJMqCvs4ZZfF0xsvqg+69vxc79VInR7GxquAlQY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gZzxDi7DAdUaLMCLMN1nOkLoOWAF3S/tWEaXSfJyKvY28xvP8
 yNSmgYyJJRpFkqvnWsYKUbzQlf5PMvOrb6THoA4txrm/rkIW2UaTVMaeh77rdOdraneMelI5XmW
 BOJasINq2AVqmLPnAxiKI+CNY8PWIjMfpzUMirYgSebCuu8nog3aewpqCTCSFxT8xy35xnB8=
X-Gm-Gg: AYBFou0GmjEGUU+r6jgqvlAmEMz8lg0xRktDBD7IM18JYK4EiUKxrgr1gq3d8fANJB0
 uqABPIsw5GsQdGFZ2nFO+V9X9ViRf5hsjR0AIdiMq7YIQDzhfSRuSsMuZFfWdkQGzdJMeyE2Yo/
 KqZmRPOYiFGX8qDuDOkgoaB6zN+N7vKREhq0OWL8vmJ9ekER6QKW4vg9pmVJA+HCBI4sFNL4hoW
 k15ryFS7VIYO3usy/8i8kwE6LQerdX1xgiI51JcvTwrHRvH2v6C2c6fnr5djfR0jOAyEIbul/c/
 bF5b3uXNsy0k0XgcNm82s7EK2avG9AwgFiqJwZ9JbISOXlTuvzgOajpEx1qZ4GzUi6ncgdFcLar
 Hg+JCwWZYDDkwEZqGFsDAY0akIVKtyTMlpatPk077LeZbqKuxnVWUQgF8v+Ye4V70Yt6lHg==
X-Received: by 2002:a05:620a:4d0e:b0:939:8148:1e3d with SMTP id
 af79cd13be357-944215b76dbmr2400376285a.2.1793705788369; 
 Tue, 03 Nov 2026 03:36:28 -0800 (PST)
X-Received: by 2002:a05:620a:4d0e:b0:939:8148:1e3d with SMTP id
 af79cd13be357-944215b76dbmr2400373085a.2.1793705787957; 
 Tue, 03 Nov 2026 03:36:27 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebf44eb1sm77475666b.59.2026.11.03.03.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:36:26 -0800 (PST)
Message-ID: <a7070853-1e44-4102-8593-857ddb4cfcb8@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:36:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/msm/gem: Disallow nr_bos for VM_BIND contexts
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
 <20261102172001.508440-3-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102172001.508440-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zLlt3eKcjLg21tRqjPvOsViha5OTBWVA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX+K0JBFjB3LgK
 6oAUXah9jz9+qnRgKbym3fwOYFze8rT0N2lWAjgRn99VJnWURpKWVJN6krJ8ThWtk3p/8+TUPHG
 31Ilt0NWpCC3FONLkGidEJnNVUPFUzQ=
X-Authority-Analysis: v=2.4 cv=RZ0FmFtv c=1 sm=1 tr=0 ts=6ae9c73c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Mlro_P0Azzi2O7fenn4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: zLlt3eKcjLg21tRqjPvOsViha5OTBWVA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX7H+7s556dCNR
 9+TXyns09vz8zozCPD61aByIq61c2xv/QG00JoITGYHMyZe9542mfhOjqrQNsknkJnQ+nUxsTJM
 pDrhsdCwEXQeMOIFc8fUfUulckNhDLo8n5T8V/5ZSoIagXKmTzcTy+4723Y0YbeXyUP6WVKSloo
 BM5szXaUQ60onTiqSxX+9Q6Q1adszyPMP/Jc6isgyCmvZG0Tj20gDYc2Di/ORZ5Q+nf/OhTvibW
 kwQCmpdGgHkNa/6c59BPm7KrXp8Wa5OpzgN3ocrdnsHmyRkO5u6G/qefJvnbQns0su/KX176t8m
 gkeKCf3cD0q2GhuqrGwttFSwnfW6UQJSfKlzlimS44KuJwrymKJiGvugPsTZCl1K/bc6Nn9Hf9l
 M4E6N8R67jTdwdCRRCdyxkCjcTKOg1UfY6xEXsi7vaos1yTaKVjaNoZxCm35zyoQgYX9Oqowl5V
 rQjYso3SW0CpZzYd1rA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030046
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 6:19 PM, Rob Clark wrote:
> If using VM_BIND, it is invalid to attach BOs to a GEM_SUBMIT ioctl.
> Only the VM_BIND ioctl should be used for binding objects.
> 
> Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
