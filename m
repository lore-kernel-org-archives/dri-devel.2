Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97505CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C1610EB75;
	Tue, 12 May 2026 16:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtzqpOZ7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZBwNfabN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC1B10EB75
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:30:23 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CBchAB075202
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RbopD8zp0138ilavAqzHYLSc0uSGjW5RH7Yy0c+EWGI=; b=jtzqpOZ7JbAz8LkV
 4kzKui/ExGO7vwstcOC65pSCtcDtpvmnBxhlpP53ByzDSKzCqtMvys0FGY2Q8KGD
 pH1i3lozz+lFcKqB3/d9eoiPsQyF0lSO08/EQ+79Oiu3WZKn8XSTn0iUmkbBlRLf
 toa65WMzMuoCarlIYJZ+xYZEQhmoi+BNOpLFKvM/WtW5x7xSbu7WVxqvI/Najf2r
 hk8F46TaBoaDh7gPoUTQA86tVyxXb9bTx+oNkwUUng8fRKX+RMs3BoZ/YVBm81pu
 eTkHh1w8a/Wh3snOGWZDTPCPsGQtXPN2oRKBk9raz2rdqN7eQezZP+KFlyvTU3UE
 HPyecg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43gyh83b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:30:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so4067366eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778603421; x=1779208221;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RbopD8zp0138ilavAqzHYLSc0uSGjW5RH7Yy0c+EWGI=;
 b=ZBwNfabNT3vISmJqXhhtH73u7CVug7DujAFu7uffj9uBgjRcvk+zHYYHZU+UWaPTi3
 SAR9hadItka+SQL9XdK7c+X9z9COlan87f/erK18KJsGB1UVxHi1Sn0lw3XsGOHg37uG
 oHfXDegHXoFQz3QvsW4Dvj3r22YFhWdHOj+VRK+HtqWD2OOK+Vws9y0UXFWdrx4MB+pf
 irHmHLb85ct8qqVTRWM5NTmOBnBvyl5qzibu+vzqzRAEYQwFw8Az3YFUFuR6wI9mKjEX
 jOjIzjgIvLVzFXZqWKRAweQ34zfSO0eiijqNlOdwdJ27ntYUpy0Ru+Z/TAWZ0Q0CQQqc
 Rhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778603421; x=1779208221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbopD8zp0138ilavAqzHYLSc0uSGjW5RH7Yy0c+EWGI=;
 b=I88oESjJSwci9QoeEQxIDSKElb3EkXWa/7N3RNQbkVGkemaGNtyO53JsNUY7Zh7ERQ
 pzht/1bTHBYQbptMuNtaX/wcCMH+vA5GTV91OQEviUUiPj5qChQIsRZj9GKShHwDnDTa
 3q6m2xH8zdNTipuzgIn0U076I7woayzIW5voWfY/0DAvPRwBd0i2cZ+aJrrCJKI+vNFM
 4JeHLwY6XHi59NH8HkqRr+mLEt1dFaRw/hFczycFnIfv+yK178AoVgciBalIDGF/ie3+
 N2PeL5N3f1xYw3YCDoMZ0q2++99w5QqT4Ut/POYJ5dki+2fCRKqLVzaSnJAJ1AVDYPIx
 C+9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9C2tE3AtdgFnw59e/2+raw8flgl3yu/z+i2T7FDdTc4ywwXKpW0Pv73KbsjNxX+UICirc6p4dhBcI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5XIdr60UmBMqgKtXkxVRga3yyahq6P4TJe2MU0tHF11BARoo4
 jXIYbct5ftR+RMgGMH7lSG61KrQafRChI7Scxd+SGzLzON/eU+gOBaojjSXlm7NE7u6PJLl3PPq
 JyuxR//dRAbuJUriy4kaQAkye3RNjLKH0KYAsHNba9+WzhMB7MIB7VVplQPtm/QvpwiCmuZo=
X-Gm-Gg: Acq92OEl0i0+B1MhpciV72TPkprtS2rM9xo/m4EIY/lz7L1FUg3uPL79s+kbnwgcYX4
 1apXryzLvSCKaeKQ0HJIgLjvfp1y9oIVR2bKZsf2p9cfu8lpZfSy8dDV7S09nXgEvFn/bTkmD6e
 Gq348isrjjKAKThba7GbPfFdvyZLIVTvXhSCBX21Zerj7J44DQwKu0aU1aWOtq4nAYwF7eAEHj1
 g2v2fZY34QqDxKMf2/UhKFIvd3pPrRmpKKwUssFxUI7gyWewhhGFbmblOuWng8MW8/Tna8cAiHk
 rWxA4WbUrerCvoFXAHl5WvVlb9Tzuh/Vkoz7ObTrUsTdeWcTDFZGQAHeqsPuBs44AVeXldq/a0q
 FPVQ9tV8FC5Nc7X6+neiJT5+xeRVC6KtszZAjN2zLpPzHkG0casOswxVlqJ5RbYkUJCQENSVM2C
 U=
X-Received: by 2002:a05:693c:2c0d:b0:2de:aafb:feff with SMTP id
 5a478bee46e88-2ffd57c44f4mr1968042eec.2.1778603421380; 
 Tue, 12 May 2026 09:30:21 -0700 (PDT)
X-Received: by 2002:a05:693c:2c0d:b0:2de:aafb:feff with SMTP id
 5a478bee46e88-2ffd57c44f4mr1968012eec.2.1778603420792; 
 Tue, 12 May 2026 09:30:20 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e4016asm18275305eec.28.2026.05.12.09.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:30:20 -0700 (PDT)
Message-ID: <53438507-7e27-4352-b3fb-5af84a0a1758@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:30:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Address potential out-of-bounds read in
 resp_worker()
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Ruikai Peng <ruikai@pwno.io>
References: <20260414173249.3672053-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260414173249.3672053-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMAJG5ae c=1 sm=1 tr=0 ts=6a03559e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mABdL3mHLo5zHP9Ps28A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: T4g2rKe-D6SK4eyIVU776zknuBgjs4df
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3MSBTYWx0ZWRfXyXgxuDub6FZo
 HslWjb2pQwT5UTJfsr1iD9DfCbHoTZE7iKP5V444bv22rdS6QtjSlB7mWUPVgBGRHNIB5jH5XeY
 nOzcHzfZhYmtV0kmN1b/5YtP3obtZkYtqgxtAPeqEGHDXYwvyvc/dVXqT56PeNoBsKqqxrCChuF
 EbVYqC5FDlCA0sxbg08+5BNWPjB7emldzIvIe9L1hgQ7QIXtqQ6me+sL2IrV7V7eyah94X9KEEi
 r20klyZlKltINqB/EGap7RlCgkcjwk5D4lUKevp/8+DEfbopnNoUGNHb1iqL3qd47KKCP6gNK+r
 5BEAucCphxPle2nj3z4ZYLS+Er7P8U9I0yQTjCXeVAo1+1DUztuurwk6C5ptxDDw5WMGEPiAmK0
 Ylm8gGtPFUlW4Uqt9sl0i3UoMyQUHqwMeqWdbTNMcAa3bta5Tb1rEdf0/sHRjsNRsp6BB+jZlRH
 w466fTknWKWnxXrxw5w==
X-Proofpoint-GUID: T4g2rKe-D6SK4eyIVU776zknuBgjs4df
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120171
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

On 4/14/2026 11:32 AM, Youssef Samir wrote:
> Although 'commit 2feec5ae5df7 ("accel/qaic: Handle DBC deactivation if the
> owner went away")' fixes the scenario it was intended for by walking the
> message and only decoding QAIC_TRANS_DEACTIVATE_FROM_DEV, if present, it
> skipped over the bounds checking code that is included in decode_message().
> This could lead to issues such as reading past the slab allocation's end,
> infinite loops or kernel panics. For those issues to happen, a malformed
> wire message is needed to be sent from the device.
> 
> Instead of duplicating the bounds checking code already present in
> decode_message(), use the function inside resp_worker().
> 
> Reported-by: Ruikai Peng <ruikai@pwno.io>
> Fixes: 2feec5ae5df7 ("accel/qaic: Handle DBC deactivation if the owner went away")
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
