Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBAFCD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326B210E03F;
	Mon, 25 May 2026 09:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVE2wz5G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kPnyXvTN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F2B10E03F
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:34:42 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P9Ed8i079559
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HDdyvgPHBYm4Smh+LW+i3c/LYOm4H7fTfg/6tMvRWrA=; b=PVE2wz5GcIfFLFz5
 arx7gYTN9h5jQFTkVdyHfb6M4R95MtY4AWmM3tnMtXBnivfLUe5/2YDDX81T8bSl
 TQ5Kl+MfoxuhfIWZNc+VBZAn8AjAmC/ad3Z6p8tJKlzE3vqZ4xTir+96i1sPlU19
 HbpXL/SpxER4dZfW7P/95JzRLo4ZUW/afwvPBS7x20G7tXqIPPddQNly6HFoXImG
 w54B3VIw//+Ka/AeDbBeuW3mA2RAoYLyrc2807M7aFEorUr634961Cv808hC1AzE
 Jkix5Ev2ja8oEl4CddQq+FyQBJWmzOdZ/zMltlFT0rtjeTXbnwtj5SPVzzEEZM/W
 Rpxr2w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckma82rw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:34:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba6fe41283so101484435ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779701681; x=1780306481;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HDdyvgPHBYm4Smh+LW+i3c/LYOm4H7fTfg/6tMvRWrA=;
 b=kPnyXvTN+OMT3jiR5QM51vDfGlBannw5h0db4VVyo10w6hnrAVonfHX4coBLuXsCo+
 logy+wZ1nIKVkiyQbFluFRGRsRs0RqlKLMcxEJFqtI20bUykdOe+4fUgVa9au3rxL77l
 B1yVxmDZnLCPInf5b2aioUxOs3D/coLZwNi5T3+MXimJZle2I47QdzaCrnnuNrUWPlyQ
 5c83BoTVGxjCeeXFle/hJndgTTJbCMRYAgYwxOqqES+PCJY4bF48zeYBH4wdViyZrBoX
 6WwviNCBS83oL7WfEF0tpVwpZ+uGwlCyaUp3Tea/r1C5NQswQgBZadoa9Woo6GMEBlyE
 acGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779701681; x=1780306481;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HDdyvgPHBYm4Smh+LW+i3c/LYOm4H7fTfg/6tMvRWrA=;
 b=stUXL6CJXSZ6IhMqwF6dqK0c1EqlRhtQMKkuFGzIxLMGVw+eFX6JM1gLRC+ydDPUmv
 VOxnjr6Lu7NjGAwFyQEn78ULWKxacWRf1vHJL6XaEOhf8fltR5KtGyjFztzO2+iBUTrJ
 QaJDZsCQm4mMXfQbMMBGlrwKjH7OaZoKOWo6JfkhhF7sR0JIVll9XLt5tv2IdtNbNn0G
 y5cMCKP3lpQ5iWwYUypeWkaclzdMWZDldo6T7JkbxBgCGrfH8MakOpChfRxV5Q7EhC8k
 iObIjwQTIaBqy0ZF568NiN9WyJFESWaIIrZdbAuwFTsqpcSb4JZwL/9k0xWJGEvsDmEs
 iCrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kmBQt8BQX3vWfCjAz3ER52rrQ26rXBMIZVdqKPjUjoHyT1K2mp1Ffgem7l7HZxbyPyZsZsrrjMDU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2OTw3btJoAvOnxql1IzG024TbUwLmp5KAgGGMkb+3pqCvSHAM
 CRx+fYLxgK+xvl6c9spTdghDcd40vyTAFhwWvhOLohP43nTchyLhn9dXKHmanvqX49xmeaKts3D
 ANInnUz9JERcTvfw18X5onCanIz+2qY3yJfd6N1NK67oZ9e8DJrtrnePYip8/Xwb8ZNVDThU=
X-Gm-Gg: Acq92OF97cFY4g64jmKNj4kydlaZcmA5vbcNBSTRIOsg8K0TiduPywie8b8DQYjMZdq
 KgPu+l3SOS2jcczVQ7bc8aBIWNx6JAmV2DlzWU2PMQ+finbbtAAWhNYqS+bAnnPSSwOVASJ8Lip
 X57M3uifvbrFU8MEQjq0PiqDMmU0YWfe9uOkHyK1ooY4asnBYpt4nl1s0BnHoJCQ4k6mZZ3BoJi
 mF7Wl9aKIqNsVDJ2g9OHrSkfZR6e611rI+6/yZIdaOx9egaV1Kvaam/SqraCTZkeJNlnS8qyLZy
 WFRK5wc06MqaKkiiAw21QN5lj1bb691lWiuQ43i9UwcYrdNV03o/Np/Bdrjuw/T1+Qj4szzcjZN
 ZX1nkB02o5oIDePISx0o6qLRnpOCk5ja21aU8/+ldnRG/f8rB48ZMCGkt17rXarHvSb1uP9YXYX
 MOtngLnM4V0/7N7SdLMMNQ5FiZrg4=
X-Received: by 2002:a05:6a00:3e04:b0:82a:7471:eb90 with SMTP id
 d2e1a72fcca58-8415f66c854mr14233889b3a.30.1779701680818; 
 Mon, 25 May 2026 02:34:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e04:b0:82a:7471:eb90 with SMTP id
 d2e1a72fcca58-8415f66c854mr14233849b3a.30.1779701680195; 
 Mon, 25 May 2026 02:34:40 -0700 (PDT)
Received: from [10.133.33.215] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9e1fsm11160434b3a.6.2026.05.25.02.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 02:34:39 -0700 (PDT)
Message-ID: <85c2bfd1-8e69-47e4-a360-10a2655bd43f@oss.qualcomm.com>
Date: Mon, 25 May 2026 17:34:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
 <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
 <lvfwkplrktjldbvn3j3jqh7ds25prx723at5t5oobsvhgolngs@pme6jiac5xdg>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, Ekansh Gupta
 <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <lvfwkplrktjldbvn3j3jqh7ds25prx723at5t5oobsvhgolngs@pme6jiac5xdg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a1417b1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=UrbuGVNNhqs0kg2t1zgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: KzeeGkce6ZoQOGFzuKzMGjOy6LRgotR3
X-Proofpoint-GUID: KzeeGkce6ZoQOGFzuKzMGjOy6LRgotR3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NyBTYWx0ZWRfXw4S0W62Iv/HP
 ID8Yvvt+G1o8qFQOifQK2auhurUfx0A5fPAUhnXsYN6DyaK11NG9wHMrVHyOQHCNQDmdRv24bQz
 etIQEtS1TIxipHUSsEWRCS9ITriWS/CUfvq/wl+YEK4XIQ4mMzbV17g6zc+hHp2wUi9Vz9fjR0u
 sZvXEydJbif4J5hRAA5w3BKTDAKD/kJms7bqvuQ3+QRxSwqMu8yCgoLPZz8RgBNWcS0HeACW8L5
 ogoz7xVlKXj4jS80cjtXgPLKjspySjHRTR9udkcBEg3eps395dH6KMrpcuybr2UE2oUF5hHRvni
 s2cuJ+2RoMH98HAEtHMdfoCDR0Uc0slQqlye5u9C6Y1nCO5P4ISpBklTuFYas7WD5jwbofp/RKY
 kmAjUyP7IDxFI0ghezG0i5bB3/CPbhdbbTcF9bMwFCZqigfU1BzF6IUSkhzmtDYmyAT0RO1zNWF
 wiwSYtBu7T2vaKFusSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250097
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


On 5/25/2026 4:30 PM, Dmitry Baryshkov wrote:
> On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
>> On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
>>> On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
>>>> From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
>>>>
>>>> fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
>>>> getting removed from the list after it is unmapped from DSP. This can
>>>> create potential race conditions if any other thread removes the entry
>>>> from list while unmap operation is ongoing. Remove the entry before
>>> How can it remove the entry from the list?
>> Multiple threads sharing the same file descriptor may invoke unmap concurrently.
> => commit message
>
>>>> @@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>>>>    		return -EINVAL;
>>>>    	}
>>>> -	return fastrpc_req_munmap_impl(fl, buf);
>>>> +	err = fastrpc_req_munmap_impl(fl, buf);
>>>> +	if (err) {
>>>> +		spin_lock(&fl->lock);
>>>> +		list_add_tail(&buf->node, &fl->mmaps);
>>>> +		spin_unlock(&fl->lock);
>>>> +	}
>>> Is it expected that userspace tries to unmap it again? Or why is it
>>> being added to the list?
>> User process can call unmap and fastrpc library won't call the unmap again.
> In the other email you wrote that the driver can be used by random apps.
> So... what happens if userspace unmaps it again? What if the userspace
> _doesn't_ unmap it (although you've just readded it back)?

If the same buf is unmapped again, because it has already been added back to the list, the unmap logic will be executed again.
If userspace no longer performs unmap, the driver will not unmap it proactively.
The Fastrpc driver will free up this list during fastrpc user-free.

>
>> Fastrpc driver will free up this list during fastrpc user-free.
