Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C425C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFAC10E210;
	Tue, 30 Jun 2026 12:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGPyUaeI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FZI+3Bmk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A3910E210
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:35:51 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9n2eF1573524
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=; b=TGPyUaeI7PD0l3ZD
 RXUKwjXocsLqVkkLw493t61d5m5eW5p+GjrblI3HaXwFRFAJyCt8ufcYOL5UMpRs
 ubYftG9AINmVA1xjbKA4MA4O8GENkvzEA/LJ66khEL8Q2SnIjCkWThxNI2Exinrx
 CwNBvO3PSUzn8cYCaTzD5Sl6TUsgjTLZsqkyo89x6+0b/eEMdkChPeMQPDfXxqtc
 xb8mu5qnGtm9zd5IB+jXQLsXM9qt5GxT54Fx/vfUVEYcCnYa9T7TQ6r+4ITYjvUP
 hEA3g2zC/RyAeRNdFTCngAhd1MZnNOYdxGSs2+9rKxnzRV74z1aCc8adLqc1zcet
 HODrGQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f468626w2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:35:50 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9692c7b2054so92508241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782822950; x=1783427750;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=;
 b=FZI+3BmkSmz8di339mVu7Kv6byxJnG7AbZvI1g99w/MpKlii4xX9AXjEfCZdDiU8fW
 wOoSIs5Xh2w96P4GfyaSmDTgbu2nDMIdOVueGG7dX9T7ggXIR9cGF+5BTK6KG/7pXI+O
 pYZAovVnrZxvg/VP3vtU12rDZTY6XbV4CBiy8ZuKBRtS0JGIToXoZJGr+ZaddCJ0MGyx
 AhJpAB+Bc8DLfVC4bPaSvYQDICLNYon3xbYwN+J50n5AX9Ofec/NRmU8UWfo888ZqvAQ
 lZPcy9/nevBdBBByWkEWOK6KeB5p3LsFERceDwCFMtq9EnJOFsJPGAWb0X1XAjihhJkp
 pKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782822950; x=1783427750;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=;
 b=SvVMcIpTdUGFbbqpCUrHuk/2Xlh96UPb2kgRoUWHjrSAzp9C5BGHtYuadyXo024cM2
 EhjKRr2+NS5ij56W8sKd78i+xPk+5E+wHUkCIUYO7EUendEAZeqtBa25SuF/mpaRVyL1
 bAeHPMVwpU9IxROv9ZSZtaQRz/PgSRq86kBf5KLd44PWLMWlL20bZKUh1QrXizoqHPwc
 5bYh6CpAOjfie87vX4Ouo9Q7qHGoi8o10HxJAVoMljvNlT0ceWxkt47UX8l0BrtptKhi
 7aWXWgpdcTR4Dsg5SyOGd9R9uFj6zVPKYGhcR2ZCYq94NU8ZZoxu0N1amFGx8fzVaK6f
 KPbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVkhshrIZZQZ0CbOA+2npAcwtCmhrZR8F3T1PGr52+04Ascrcd7yJksDD1R+gh66djZe+2db6T4jE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1jL+9CljScBNSerR2o9RZWm/aWFVxa0IG4W0ceagSvsT6fnnX
 RhU9tJRJzoHVZNhr1kLW3Wds2v0YfyeRIA/iAWY441tDEM0q3+N1wafOdqktxkILdAK41aa3sfA
 Ho+I8kx/6IAkuApooz3wwo7QBzad1QvgRioFZkmmC/clyVb7I8tYGWmU1OKgs0aQbVgD6dis=
X-Gm-Gg: AfdE7ckJgyOwIEM3fR2QcSbguSqFsLdXtI8k6zUSUenZaPRdOUbUosEB4wFt1RGcR7A
 ByMihOhYZS6ZJmhVUWzV1ZYHRfoneKrWqLUdZilkUxPuOun8mcvNlIGZLDFS7b3P9lK9xzNTDFU
 55PDgN595pHhrMqyYBEHUtj423tlYasdJDXEx1OeW0WtlYfyMmUPqxbdASKNbMauZSapELp+d9E
 zx0jyeYQ/qGWQtHxN7n82s6Fmp9BSvbWCmyNOSPzeNZAMOZMH3Qi4hP1KICcyiolrVtpGEvy957
 TCr5BvgbpwLVEqUkQ9iGLicYpFByAswQZVPHd3juHqBbX4z2hcPtWman2Dv94EK9a3xDTZmwYQG
 nqorevLDLHsPDjQgWTGEF5dgr1HqskTDIVvs=
X-Received: by 2002:a05:6102:f89:b0:738:9abd:9ebc with SMTP id
 ada2fe7eead31-73a333cbc93mr634694137.0.1782822949906; 
 Tue, 30 Jun 2026 05:35:49 -0700 (PDT)
X-Received: by 2002:a05:6102:f89:b0:738:9abd:9ebc with SMTP id
 ada2fe7eead31-73a333cbc93mr634672137.0.1782822949547; 
 Tue, 30 Jun 2026 05:35:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69885c9e8e8sm441434a12.16.2026.06.30.05.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:35:47 -0700 (PDT)
Message-ID: <049a4aba-1c35-4a47-9a34-25e76ae8e72d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/14] remoteproc: qcom_q6v5_mss: Switch to generic PAS
 TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y3n-4Gz0jvhHQPsITLAg3sXOOjM0QgQU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX6WU9NKyE0rIe
 3YfHiVTzUJFT7Yb34NQ0UwhRI6Atty1nTzo/jZKkPM4qidVDS60izO/K0LVl3w1KZSLvhMWEe3i
 zZDQXojPW2to+O3geqsBOjbNTtQi4lHVfDIQCO968dDiw3Rzw7/6p399VkPi+GHaKa2AElZfXBA
 ErpnPoSzys5VfItreIos8sPns3xP98T+XTgbLyuClVaN42UxokhFNeDL1ovY2tZZQgyJ/WS0C1E
 Ez+hD62QXqajUqlM+G8AW7ckeiIB/+WjRvK4HAT+5GtAr1tW2OP2aCgdy/83SvzTinFuPuH5VHK
 xKB2/+PWSPqP3PXwghgxNo+jAHEtyfE+NhsdBE92wzUGukqJeJkFg4+B4YNT+SIcwigLKTHQy09
 VBdqBivHHbgR/ET4Wc1rw/M1yierOQZUYOmy9dCzd1RyqA/MJsqG2KB04iXX0dwvehVXNUketsj
 S3mVCAm9n88iOLA2Wmw==
X-Proofpoint-GUID: Y3n-4Gz0jvhHQPsITLAg3sXOOjM0QgQU
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a43b826 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Vkn3R3B67r5ClizzeDoA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX0NBInT9oM0Xw
 Y2rYDUPVrsvSrqjn6WdF+6okcnWW6OSrjsVbK9IH8wGS/3GO8oN4AMyfJfI4PJC6L6bki9UZb+9
 59PGbBqjIIzC4I+3qZVyRHHYmwNypQE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
