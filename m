Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D0FCD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E0F10E65C;
	Fri, 22 May 2026 09:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VYHtM0WR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cCaBJsok";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C2E10E65C
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:08:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M6MAgw1298251
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mKwTq/x1CgdeyD6mhRAd0X8c1OdQ+gz6M1HFcjRwlpA=; b=VYHtM0WRdfskSNMW
 rsbGP8eTuOJ0Zb3Uu3HOV3xUpU62nsl1tHo4RVS7s8bcUFBNFMAh9+5OE7zsAzUO
 /Fi7+bDUMYqnNCa7wa9OYvShXEkIPuWfqNIOv6d/7R0DISZQPEqd3IBgR9VyAoAd
 v5ZrZeKGitgRiPSr6MLombB2xLWSgyxsVPLt1/9zAe5e0Nj/UX1Qovktr3jW1apY
 EvoXL8QIbeBkkQAz8CRsPsc3mv70zmQlhRzgGZpC+rs2kSZ2sVaFehscKDUI6Gqa
 /R/RWrjf6KBRW4ioyoq0tbNeclLzB9T/+5VeWMTA2AuL6HoyoOR/Fau9xvoayaKf
 ReyHRg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0a6st-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:08:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f74bcfb86so8995123b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779440924; x=1780045724;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKwTq/x1CgdeyD6mhRAd0X8c1OdQ+gz6M1HFcjRwlpA=;
 b=cCaBJsokrgGij6vrQdMibJqrZ7JKmIBOrqdZQt6LJtuwNEOYw8xRJMYSSF/I31w//E
 yAy9Qo11uWAj7N220eV8nmkpFPdRcufkhu1PcANP0jR5IBf7eFOOfuBtCtlxkHKoEy9k
 ddTD46+ua2USfpsj4fQBXeG8IOQJ6JYz15TFKpOHKXezbsR++FyyW+BpZxs/0Up5vqMC
 cDz52ipBiRMNjkEYNcNtC7ydfp7KFu5ShOWLrVceiSifV3qLYC+MuQ6Yt6DSCRhaFSaI
 zZ1lZxDawAMY56sYCn0hkwLR1nrYk9t5x+06ALw6wBiKuEdOEGgbypFT/3sldnXxgqC+
 ekpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779440924; x=1780045724;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mKwTq/x1CgdeyD6mhRAd0X8c1OdQ+gz6M1HFcjRwlpA=;
 b=hZo6VLor5339kLViGtoFtftRuF8MAttJx3g/9htEtFIYxoE6rBMd4qXWfYbGJRGfJI
 s3gTMdFrCWFc5KHuG78exzthrmxyN4g67yacpx4+1OAY/iYIoTxHFCwpZbbtL/Sc3mhL
 hZsGRMP4Wj9zXTgaBUjvS4WrH0WzpTFvbhQomJ46Mr23PfHP3eqVELT3C0WV+z2/A9gx
 kFzBqvBDHYIqNridYG4R+rkfK1gtjHt5WRT49gCCL3JyufJKD/+HtYJWqfnnilFWx15l
 pNFckU9q3+Z4UQSIoa2xlrRCC77i0eax5U+tDC9/jfOkYBuz8AwcEvxMCIACP6Hw2g62
 ZzuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wr7JTVTHU0ogEGtPxzAKtpwyfz/5UnqayzUl2KUMxbVol30UP1Nr7RgFlEFTVyIYX00uK/K8JQMU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHCwHZD5wbuQaEVTkY1FL9omVD8Hi/d66qSQj4Z+kZUl12Tj62
 Z4LX4pX8Su/WkK4sFadQ81n8oVelT6N+DLYgHaBIfFRg+xh34pBaU6NUvMxaQXhf8w8e++t1mVl
 8QNzDaPqndL0fFcRtgk5LHA8qi65cGINqFiCKKdIPP4ETTIEm5JmLn5kPSy58Svj+eTAAWkQ=
X-Gm-Gg: Acq92OEzkxGDrK8GZZZRoyWvWbV0xuKtg1hso9IGCSlSNr7zZ+m9TGl70bQUltsAFU/
 UYbD6sFivHMbrQ3YvUlodd83dy1KrE4I7KPpnmGApBlVYDEH7xrujNRSS8gpj4Afh3J6z4SweJ1
 HBCmqDhCTQqDvPAQVeE58d5wpIgCbaxbXmR6nxLIbUw3ZVSSLCPo+kuDZBcBir4aYSDJzyOJKJA
 2g5qNR9z4VwJK/BW04q1fuoMUoyaQPMtKalJ8qkw109uOsmOiJ+V0Ry2C/xOrdcK6vBvzHUUjMv
 sOnQ43sEFZHl4VUUQkIwoRd4ZHBkx0b+h3ucY9sLUybBr/uf/3yl6VT95LnrgS2zyPT50RKzG0g
 pzu3tWXVlk2yKStNqR0L0GGHikLLw6Ijk7Uumtqk80KXM54oMrvAqOcehqcVQ8CkR7Fmf93ZzzU
 J8P/hR+CggP/dvRevl
X-Received: by 2002:a05:6a00:244a:b0:83d:a434:f099 with SMTP id
 d2e1a72fcca58-8415f11f764mr3127959b3a.5.1779440924397; 
 Fri, 22 May 2026 02:08:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:244a:b0:83d:a434:f099 with SMTP id
 d2e1a72fcca58-8415f11f764mr3127918b3a.5.1779440923866; 
 Fri, 22 May 2026 02:08:43 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9ec47sm1576039b3a.32.2026.05.22.02.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 02:08:43 -0700 (PDT)
Message-ID: <5717a34a-d998-4f4b-832c-08941d49fe54@oss.qualcomm.com>
Date: Fri, 22 May 2026 17:08:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-4-jianping.li@oss.qualcomm.com>
 <4f8697b8-d602-4718-bc8f-4bd0dba50040@oss.qualcomm.com>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 amahesh@qti.qualcomm.com, arnd@arndb.de, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, Ekansh Gupta
 <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <4f8697b8-d602-4718-bc8f-4bd0dba50040@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MCBTYWx0ZWRfXw1emV6/InrZw
 /MqDCtc+iySXNRFZ2S0EE/ozj9xL2w7st8wUArx3dDiFIbvrB90aYMlF9UDKdL36dFr1hb4seRe
 Q3jTDT+V0NXJ5sCpgrAWZ5BVMMVyZild1rfyjATplF9PjELpUaPlzApcgH61uutMGgZe/rOZM98
 T6QnpYMd+xImRF1rs32nokY3awxvsCrc0fPBPV5i0ttS+lENCqG5uv/jHJSIah/a5ng73cl1hME
 1G9Nwk2EmkWQYlKxZ0WdrzesXiXf2qhhKS9X95KRt9DYCco6GZQGoV8eFEjOJsHWGXG98jo0rhF
 hjyIIUKD+2f8QXtEP+MTfCPpcsUfwQ2GnTMriT9iJISlBCYHoo3ec1SUGpF+XYq9uwH5SKGbPUe
 sMZ/k9SDf+WixMBZrI+bVS7bpDa+CNqviGKFx5NHe8fwF7Oe9M1tvtmlALZ/m/dPDlFBvFBM73s
 4loM2taz2Zrissh6KwA==
X-Proofpoint-GUID: M-cP6B2LhohTF9iQ8ZAQ3He1jbZr9Y0C
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a101d1d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uBSpvLV6fhDO0Xk4A2gA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: M-cP6B2LhohTF9iQ8ZAQ3He1jbZr9Y0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220090
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


On 5/18/2026 3:59 PM, Konrad Dybcio wrote:
> On 5/15/26 2:42 PM, Jianping Li wrote:
>> Audio PD static process creation assumes that a reserved-memory
>> region is defined in DT and exposed via cctx->remote_heap.
>>
>> If reserved-memory is missing or incomplete, the driver may pass
>> invalid address/size information to the DSP, leading to undefined
>> behavior or crashes.
>>
>> Add explicit validation for remote_heap presence and size before
>> sending the memory to DSP, and fail early if the configuration is
>> invalid.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable@kernel.org
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 3c7c3b410d7d..a0337cce77f3 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1363,6 +1363,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	args[1].length = inbuf.namelen;
>>   	args[1].fd = -1;
>>   
>> +	if (!fl->cctx->remote_heap ||
>> +	    !fl->cctx->remote_heap->dma_addr ||
>> +	    !fl->cctx->remote_heap->size) {
>> +		err = -ENOMEM;
>> +		goto err;
> Let's maybe add an UERR() with some context
>
> Konrad

Planning to move this check at the start of this function as per Dmitry's suggestion.
I'll also add a dev_dbg log there.

Thanks,
Jianping.

