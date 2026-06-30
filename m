Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C611C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECF610EBFB;
	Tue, 30 Jun 2026 12:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hMAv06XB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PrM254yq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A0F10E1FB
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:36:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mn5H1541506
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=; b=hMAv06XB7kVL6dKY
 +mHGw3jLF/V8VbrZUImQfj2Obz1kqidz2H33ovgOc19u+mb+yDLaOpPN/kUCihqJ
 VxyDFRhHHF3LE+BMpwV25kokDuysV/+xRDcxCR/nksSgx/Y98VucDYD/N4RQvqAS
 RfzOiO2B+ckua6pWwG5ZmOxuB/BsGWc4mZ8/uTlRsGQW8OZvq0FVIp5Rwvm2/qnM
 rHSsXx4FPnD7merqI3IYjqYhb4n5YQSq2ebVHHhxuIgh4ogpK92nyJAxaWQOyjrY
 yPhPlQTtcEYNELxEP7xiMOsLVXEo0PekJnEHp1ItAwYxkBJailhxbT8YtECLlLUg
 7O5slQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp2f25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:36:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e57e56ce9so22542085a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782822995; x=1783427795;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=;
 b=PrM254yqqhXuyLo3oXJU4tm8yrorNernrU4XNkicbNZCLxTD3cZ3uPIvu/TDcSNwWs
 dAPgpoyBhsefSTF3HEl7oIXQJAvWkrBz4fU/V5w42YfxyZU/R9wj0n1Lt/5/MZDkPZ/X
 g9WldzELwGN/0h2ZjUPpy5AcnKy+qV1OZvSsduWXVtKw6yKEoX7NZuCmdb8hLoSYsYqi
 2q4x1EWX62s/H3TIptON3F+CZKiowxnvXiAY6DF5TESHlo01+QrrdjNmlFhbBRKnL3Ja
 w0+E5ZWsPdV/0S7VzwiRGLPOnV4xa+0LI3Xlcy16PWkYXUjPwvvlgxRw68y+MNUAAnoi
 3F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782822995; x=1783427795;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=;
 b=h2VYlaQhPnLICRZBOe6cqI1nkKQTxgeOOBpM6NBGzCj9TWZ+fMpTzBUzj3SUh+owz7
 0olNBvtaxznOtDpXGvMLZj//NLAuHkWfMLGPSqI4/OaSPoFfZQDZH7xEInNvKzusHo0Z
 V8yer32FDqpMFJEJKcmlfQnYRZNyWREuHztsvRe0f1MjqxEEcC86xxQWiy2tfc7KCXvG
 UboeTmL0nBMRMdCHFH0SdceQiQBAhtNy6KcUmxGtp3UALJWTuK1ioWI/nwsOmc8E44es
 26z9EIDIhTYUQ7x8yj9qE+YkVF5bk5MY72qzVNZM599yztNKJL1ZdUtQ9PqqR2/8QcxH
 qTiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vIkgbrYpBy//jyO0hyoDDCsgewWqDfmcLSFWFTUvsgILNDZjVOYqftS8p0YhS8kFTaWa2bP9k+bA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSxPQkaCmyibNpgJzdeHC9zh4fMvw2wubnwz3mRC/xYTsBfA3A
 2l35HyHi2dG13htJihcYJDmC2c4+llpBQ31yyhOI1xCHzKzOy6rFhVpzgxvzrx2jhg9EK+4DjwN
 GnQP2lHN+bi5v8fwldeSaUG/Qv1PBRdL18BLlSECyWNMdnjfr+zzFmwkQrSVHIm4nQWXEHSw=
X-Gm-Gg: AfdE7clN8pbNh+gTcd0M2SB1qF5m+0lY77fZ2nHmdXudWFdOSqsi8F74ltgwlwM97CR
 Wq4RjVT8xigfdxvJknATb1hXMYHAnh+A8eTMFHuhh0c99vtzDMXreo6fpV+389ufyyM4jjb3sPh
 qKwVSOwc2BsB8j4+gSQSvsMnNzlMzameDXhYijTjsxxHnwZjssHpALPyz1ErZiZ6Z46fVrJdgsl
 vqtxcxwxeFKLxndMZI0ORwc11GiJEXn4ZqeQy3bojDHc1RAv+aZk3opTvtayIU53vEjL4FMXXuj
 nX3YWUgfJtRC+UddQ5hSI969dveijyD0EO3j/CD/ws+7LKspT7PXHnx92aINPp6X2P3CcG/h+jI
 j8gXtm/g9M3gjbn7SpQmbs6aJk0RrEO3J6ho=
X-Received: by 2002:a05:620a:2a13:b0:92b:14bc:7936 with SMTP id
 af79cd13be357-92e6247af35mr377074585a.1.1782822994717; 
 Tue, 30 Jun 2026 05:36:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2a13:b0:92b:14bc:7936 with SMTP id
 af79cd13be357-92e6247af35mr377067885a.1.1782822994089; 
 Tue, 30 Jun 2026 05:36:34 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1288f48b35sm115852066b.46.2026.06.30.05.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:36:33 -0700 (PDT)
Message-ID: <6ea161a2-d959-4028-8aec-175b73df18ea@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/14] remoteproc: qcom_wcnss: Switch to generic PAS TZ
 APIs
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
 <20260626133440.692849-7-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-7-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: E8hR1jTig4qQcruamh3JVSZrcw3w_QwQ
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a43b853 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=jx0KCs2Px1p7SxVd6dwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: E8hR1jTig4qQcruamh3JVSZrcw3w_QwQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXzY2kaHHsb7Wa
 +9AvsASpGU3q1YoVhl2IJKvXvfVKi6pilrvFI9i+QfY+eEAMlftGkvhRNfybbhbvYcLroEm40vN
 c8DIPqj1d/dHmkkh0JHRZI288QK2YjxCcixYNb25EILBBKrNkos1+TBOoDES0nkRIgFhbkIoG2G
 X7nnbsCR7QmNHcAhcirzzRcwOvBIHL3fvxc3uIro7ObtPMQK0HAyi+jCjbBndFe0ZX/nPbVUvpW
 tikEM2DQQUmWaa02Qk7thTI4TEBkI4eOjOQYuhLGhZZFDixT+vvlB3gJEJbuNYlyqj2V9SSyOPG
 WLFDYtcVff10uqBIOL99oWIdPsghtIxsZIaleHcd3PDqwgQ79R7zbOuuuxKywnh7fbNltIFonSw
 gzfeN0ZyrSOPk5PqPI/ei9iTZaKOcmrc5ChPTgNNn26WqZPkYcGR7dOtboeXF0ByTiw40UnRy7/
 zVUz2auQFQgg4zEvVkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXxqNJj4GE06ns
 5oQr2MJrFMl3meqF2nWGz8QKgynQFgywC3CYgwA3nn0dYyKibP2BB0OqrMkUEYwRl6Zoqqhc8Ea
 zv6OxpK06Iv9Yb+vU2wpIMJ+Sp3ubJk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
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
> Switch qcom_wcnss client driver over to generic PAS TZ APIs. Generic PAS
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
