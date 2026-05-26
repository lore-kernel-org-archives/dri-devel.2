Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ED2CD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 06:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA2A10E44D;
	Tue, 26 May 2026 06:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nj9xsrCm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Do7xYudm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CF810E44D
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 06:59:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q2hAWo2822957
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 06:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3LVvCV+OUMP+eKOrIZZaZLZwCkJ9amVnJmT5FmWau3s=; b=nj9xsrCm/lOT11kn
 ZnRRjHjYdlK1r6DvR7j8lL0xfTKmOeoGT0ZCNpAhzRDrODPhARMSlJJSJYe7kBnO
 Ue4e0NBmlMMjO+f+Vd2xkdIXeViCcf8+VuheB7CZUrd6f9WrwZUx0Yzp5nwtjTsC
 uqOU/UqrQ5+RxR1JfJ4xFv8R5aCwSro4k7DnJh+1fkMqOsrebnwyIvak55V0FzoI
 XgT+UoPsvDibYhb2t4wMX4rGyZU4OpBOvn9whM5z9xMOHNHcp8ZspTHOfbtMzRK4
 +66r68Gv7TQ3WG1K7/PGg7+zM1oEv4vaYmfR0x0Gz0Vb3JnbS2zk6Ko4r40lX35r
 hgMp4A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqvwtfrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 06:59:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-366ded5ab5fso20019728a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 23:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779778778; x=1780383578;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3LVvCV+OUMP+eKOrIZZaZLZwCkJ9amVnJmT5FmWau3s=;
 b=Do7xYudmqj2SykDGr8AWotd5Fnt6MJ/poUYSqFl1dsSBoIXfp+sn+sYktr1dVc/qYW
 rMk+SwO8ppZCFgsXjAfSWc6TGBMmqUpzlN8HfNUntscDuCCsv+g3ls7Iyu8c6etzJK3o
 ptO2AQo5jTlpi0xGjdxLRD0uLxlaFr0xpdOkykgCM4zx+i8lCsJNFqXKLPQB+X6wMUYE
 fHax35jaQsyT+BnIXZo2Ga7NPqDsrwf1XfjB8b9SaTPWMmGqkJE6r2FiyBU6892GsSBu
 bwgE+C4cfndtq5RpxpR974/i/0n3/0Mxfys3Djf4tAcDGKyA7Ck/YZUQRLXsyPRgDtn1
 HH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779778778; x=1780383578;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3LVvCV+OUMP+eKOrIZZaZLZwCkJ9amVnJmT5FmWau3s=;
 b=ZQkn3mY0xX82mgojNRLYxyrLcrc9d84D1V6+z5nY5qVL7g2CgkGu+UQSxQQFi5+a/J
 UsC4Ki2iUQEzM4/nZMPK2lR9zfws2eD6F265toLNQ1WjSE4zWK+ggHo0NQqdiQ/FbJVY
 EiFdwl2HdvqErZaIimwLQ5PLWKJQtWzoZ8xm9990siXtE0iKb0LMg4fGRAKUeVXI0xS5
 YtOShesa2KMSQkXnlWSAT29azOuay8a0IYpHbwO4fOLDbKQSB/QdzT9Nhuhh+sRN77ru
 S0d/TCHWzfNsSAi4qjXTmt/CEW7R+HTJmRLkPdQj7mQGfKABWcmZZqiOic6d5ii8+wcN
 7Wig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LGc7H1SYedNhTAdC1msY6xaehThaUMzwo0IXcs+IU8FIdKhSwbmY5wzhoFB8FH2uWZoUyM/Co9A8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyL+uhuYwVSm+eXK5XfQtbhwpq7HYyR2txzW/IG9bGUrdf2hCtB
 36Pb5SsfaXJn1UNWfVVjL2ZyxoMzTKyAyT/RFDKRS8iLCTPQCGDs16Uem6OWkSaXk2mVZqb2qc0
 vxmAmLGEg11FBs0hhyFPMcHbsv0FuFtpY1+X4mJEnec9J5terNbW4DQj9M0jZgsScSueo1vylBw
 nBVrwZOw==
X-Gm-Gg: Acq92OFgKuufBe4gsJPXjwJfrup0rhLgvm1ZP+mYmiPgcC5bkEE/4aSdRwVz4o6DETv
 275F39tbpWRaR0IfQvlYjAx4SxW7zgWb+6mt6JUApRPNSzNUaTFoSeYzD/K023UxvNn3DWIuZN4
 Q9jaUAeNJmu/F7719V+AQ0axakjc8kg1HqO8+ZU9QizN/f+WEOq4TUB3hrMV0hXXGFixHXGJhsV
 M12kZPLveX6lfxX4u2BiGD3F+fbef3K4wfBjzaayjIRZD7bEVTXYfd6F7RwV1ZwqKJDJ6nl7q31
 18VAyip+kWczSEoU6PLe4nBbpm4FZNOyHF7H0B1VW/wiiOUEnvW9FtfmE2PQfMbwwIxLng5GkaJ
 bIKINnuHHM2w5qydetXwjSpS+XySM9jy0y0aSaOdYQ6sHdBXLf6MDg91iD5mcsMF4vZJRF1lZvy
 c2MI9jaPLFuIjw9gRz
X-Received: by 2002:a17:90b:5746:b0:364:78a5:8d40 with SMTP id
 98e67ed59e1d1-36a67639d6dmr17650198a91.20.1779778777716; 
 Mon, 25 May 2026 23:59:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5746:b0:364:78a5:8d40 with SMTP id
 98e67ed59e1d1-36a67639d6dmr17650176a91.20.1779778777240; 
 Mon, 25 May 2026 23:59:37 -0700 (PDT)
Received: from [10.133.33.225] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72674492sm10892004a91.8.2026.05.25.23.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 23:59:36 -0700 (PDT)
Message-ID: <4dc05557-ab95-468f-b972-84fe9fa3cc51@oss.qualcomm.com>
Date: Tue, 26 May 2026 14:59:31 +0800
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
 <85c2bfd1-8e69-47e4-a360-10a2655bd43f@oss.qualcomm.com>
 <CAO9ioeUgeo-MiP7pNY16wL9d7LKEi7PR7pJtH=1hMg-mnMSOPQ@mail.gmail.com>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, Ekansh Gupta
 <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <CAO9ioeUgeo-MiP7pNY16wL9d7LKEi7PR7pJtH=1hMg-mnMSOPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fMe43ENUo57cbehubWsqRuWEgP-Adt8P
X-Proofpoint-GUID: fMe43ENUo57cbehubWsqRuWEgP-Adt8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA1OSBTYWx0ZWRfX8uR39glq2s6p
 idJ9+1tHgxlBYWhV79QK0CrMxPMI8OdZESiHUyUl+ormowDiJ0QhN3EvoH8aRAljyHLrNnHZKou
 EN9OPwFzYcTPMLeb6WjR/UjmPwK5oTSVUUKdxRkYCMrQtJnpiAz7tJYTwjLkbpylLo/+cxKPDap
 b0fH1gViiKAE9BefOXwHjlgFRYwULUCE+aI5EvpFxxIgrEKosCMZ8scz3XB1Kc575nyWh3lL0TI
 8AuzG/SpsEKMwKSUBjmZcYukr/hxxCaEONzEBuy0PmxtAPlBVhf8OHkGoFCFA0dT5JgNqja/8ej
 QgJQhEu5IvHHde9zM/OQsIesECmcSQwSB35+ssH2T6GF7T3suhgGTEa8rTQ7C83BT8YozyHd8q2
 TsiiSLdNS+9f7o+xpv9t5rPRE+XwUZYyc6bwcEXcr8nkGy139gMgQrPnQTcRJ1GSzqDwyAahQSg
 LQVM9gULvKj7rx13rYg==
X-Authority-Analysis: v=2.4 cv=M4l97Sws c=1 sm=1 tr=0 ts=6a1544da cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=HEe4avgjgsDiN2dfqW4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260059
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


On 5/25/2026 5:35 PM, Dmitry Baryshkov wrote:
> On Mon, 25 May 2026 at 11:34, Jianping Li <jianping.li@oss.qualcomm.com> wrote:
>>
>> On 5/25/2026 4:30 PM, Dmitry Baryshkov wrote:
>>> On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
>>>> On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
>>>>> On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
>>>>>> From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
>>>>>>
>>>>>> fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
>>>>>> getting removed from the list after it is unmapped from DSP. This can
>>>>>> create potential race conditions if any other thread removes the entry
>>>>>> from list while unmap operation is ongoing. Remove the entry before
>>>>> How can it remove the entry from the list?
>>>> Multiple threads sharing the same file descriptor may invoke unmap concurrently.
>>> => commit message
>>>
>>>>>> @@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>>>>>>                     return -EINVAL;
>>>>>>             }
>>>>>> -  return fastrpc_req_munmap_impl(fl, buf);
>>>>>> +  err = fastrpc_req_munmap_impl(fl, buf);
>>>>>> +  if (err) {
>>>>>> +          spin_lock(&fl->lock);
>>>>>> +          list_add_tail(&buf->node, &fl->mmaps);
>>>>>> +          spin_unlock(&fl->lock);
>>>>>> +  }
>>>>> Is it expected that userspace tries to unmap it again? Or why is it
>>>>> being added to the list?
>>>> User process can call unmap and fastrpc library won't call the unmap again.
>>> In the other email you wrote that the driver can be used by random apps.
>>> So... what happens if userspace unmaps it again? What if the userspace
>>> _doesn't_ unmap it (although you've just readded it back)?
>> If the same buf is unmapped again, because it has already been added back to the list, the unmap logic will be executed again.
>> If userspace no longer performs unmap, the driver will not unmap it proactively.
>> The Fastrpc driver will free up this list during fastrpc user-free.
> It will free the list. But what happens with the memory mapping?

When device release is called, DSP side PD is also cleaned up, which includes cleaning up of DSP side mappings

Before kref_put of fl, we call DSP process release, where DSP PD is cleaned up.

After calling this, we go ahead and do buf_free of the list

Thanks,
Jianping.

>
>>>> Fastrpc driver will free up this list during fastrpc user-free.
>
>
