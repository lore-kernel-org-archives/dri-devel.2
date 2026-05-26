Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B040FCD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2F810E456;
	Tue, 26 May 2026 07:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WyG4JJDR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WC1mKxzI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E872010E456
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:25:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q5sAug1802358
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VHBSErm/baHSTdbtmVoVnrvbO2RjAxaPcuo57MHOiLk=; b=WyG4JJDRy+Bn8Nj9
 SWdxHM4cP0KOoXe/i6V0Bx+lGDSCB+mVjvCy/y3U8eErNsLEXjgZFnG8KLLBA3f1
 jveT8o3lLBMNCTIpt2YlhMiHTDe9Xozq2jHaAb0ob4sBgTS5WFD/4kzo8B1Zos+D
 r096IWn/6aqR5WJIeriLF5O/X1A8+NrabCd0kAJlDTxSTMb1inAUJJ+Qxu/uUrYg
 BmHGLdm973nuk3A4fkr3PWg6IZgvHRGUs16HT4OSGQU4X+K/CT/oX+tKdxnEm5Wo
 ynSZy33zfgtlHN7xbs+fa40YNd/7fLC/rGsYMi/0XqxqpQ1w394ctMubgNU7lqm3
 DLfNag==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqkgw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:25:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba115ab6bbso112209275ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779780317; x=1780385117;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VHBSErm/baHSTdbtmVoVnrvbO2RjAxaPcuo57MHOiLk=;
 b=WC1mKxzI4SAfFBfyFnXUmOQ7sZgA1UOfvpFrBUIGzlb5F0+u/SK53ulg5rJqZqVpmc
 pD+HikK2vxdjkiOqcEMz50lAaQKgs4COq3LJeWRGfDsGcV8smi9J7Yh0sw8rCDggCWDm
 BlnSgnUejdzMwx3hAeMVfpre6UF/yHprf9aqGp5kbpP604WAXWfhrx8Rh8lqND7adH3v
 2Rtb7gUZkvFJvK7YggD7R3P7Ve1oJq5cCsy4nAc4RM7tqX6XYyVat0yL/7/72k59qFvj
 +GwhFoIK0jmSQagqEiBIyFjoWdbveRo99IkBzii78eboCRGS8cOuY8gOwWfqbhHSEElE
 mzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779780317; x=1780385117;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VHBSErm/baHSTdbtmVoVnrvbO2RjAxaPcuo57MHOiLk=;
 b=MXPrK83GPjGPp8YxvRj4kmg9XSDa9SJrYtnCOaFG+3IsogoTQaHYZucYz19ljdoJXp
 ur8iUSOu+VykuH6Vhg2OI5IV+kk852Mk6x7YvadXb9OzjjBnRhb9t85ioUGprKVXwzZn
 a3wqiQp3J+/K+DGXzCV0yuZCObEa0Z2WJLHZwCioAvzEgk0YxhhUTjSFaRLId1flxGFr
 oVpOOJTnkNnBnrMnriM1tttUyfKz/c+yBRrquXBWF/G2O4EO0YIqfKhLCat8kfCXKTU6
 U79Eb+rwq01pLIEhLB5bn4u29jhSs/HaSrlZaaANoSTJIB0XNZKvj23pYdLdvsrBcjRR
 D0og==
X-Forwarded-Encrypted: i=1;
 AFNElJ+84CvDEYQPI+JAJIaw7Yzo3NRJvW/hkZ8PJV2ChRgxf3+Jp8zW+yvuWiqdunkHAOuwislI7fd3jcA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwINFNYna3puh7vy492KI9zegzidTk7fn2IFzUydDLc87dSo2tU
 EEe/QFpZEeb3MmG/7BvWrx+Y1EDDqZjuuK7k0sJeBzMq7Hj+voVNgZyWO0KPsJxtg4bKh9uvcjW
 +8MpS77rbIo0EYkGIZCRSHU4oU5LE9I+CgsW/e9bmfUPtv9bLxduAv0MzY5Jw5UlrgA4sUJ0=
X-Gm-Gg: Acq92OHRABzJWdTJ3xedqgH95ApxJDlARdmop1apJXDK5EgtoDhK3/dFZWA+01EWLu+
 FnxItB12KZfa+WoaiZjNg3eZzMpQopKvcEe+A7DxLIxKyc3uqYwxiUMw/ifRxFXOngi3MQrvCQX
 4Qr2P+BJWWrcYOBKPHW4IBt5Tj4K8WFaXjRpw1zDHePfSzebCp1wor3Yagrz+6yFRSA2KWxywrD
 FhkvUL/krPLLjLxbp6VWxzFMjb4Wusrmyxrib2XKN/aHrvL3Qzqv8rddgibVIxB/3dMwRoCP8ic
 6c0rspbsTJqI2e2QYH846T1f07HWQ/Dzu12NujfFD8JcaFLHeApjWbvdEv2SSr2aBpF/q8BlkUZ
 ynqS7tyr7TvGIgk0hIWnFB2/ZvnC/Mbj/7UulSK2AkLNOrI1OO5nqZq80ZaW5sGro5WapxKz1o4
 Emjk/VIK8CCPf64sGR
X-Received: by 2002:a17:903:32d1:b0:2b2:5597:bad4 with SMTP id
 d9443c01a7336-2beb0770f45mr198289215ad.30.1779780316800; 
 Tue, 26 May 2026 00:25:16 -0700 (PDT)
X-Received: by 2002:a17:903:32d1:b0:2b2:5597:bad4 with SMTP id
 d9443c01a7336-2beb0770f45mr198288965ad.30.1779780316320; 
 Tue, 26 May 2026 00:25:16 -0700 (PDT)
Received: from [10.133.33.225] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3058sm117251945ad.39.2026.05.26.00.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:25:15 -0700 (PDT)
Message-ID: <5b838092-8372-4ffb-9367-a78f19ccdbd5@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:25:10 +0800
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
 <4dc05557-ab95-468f-b972-84fe9fa3cc51@oss.qualcomm.com>
 <osegqij5pitd7fjgpbslddbqgbz7lqrsjoneyep6izwu3kynhx@afvrjqpib7bh>
Content-Language: en-US
Cc: amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, Ekansh Gupta
 <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <osegqij5pitd7fjgpbslddbqgbz7lqrsjoneyep6izwu3kynhx@afvrjqpib7bh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a154add cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=3dfTGY2RfG25o-zzpn8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: kJCGpIuEA_VkVjZ5dDw0KYcW3K_3-EEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA2MyBTYWx0ZWRfXxFOI+9P8AcLe
 oUbu/rqDks5xHawisqB2JufXmsUz80FmETPR+wCr+K9eMG7htJhkwWHt+tsL/jCb0D7ORHten91
 6ZYjTNQTOhJNyB0souMnhzglT7tpf3H9jVk5qf7FKqkSwrQJjQNG9b9tgE9mbNkBhYdMguOxmDP
 5KLDuoJ99X8c2xCu/kcZ/TfUahH9UwyXpAqkh8Y15dXkzBzuTfpuZwilNiPJ35iqBHKKa53jzLt
 u9daEGBvSQ4RyNW/nSWW96/9+CJtPpYOumvW6HcPte11MOtZQHZSuk0c6K0ViT9aWtJu0o1p5Pt
 xvE5GCLbr2xWhmgtIXkGgDHnC0QCBhE6xfmhsRYPa/OkR+ga9mp06afEfbiOHEknt4CdyE6wmt1
 HhchiTB1kOP7Mxc9tVcRROwN2Rv4QPmKcAHth7GPKNKkeewQzAEyUFufVqZQkiWxd0FgG/qQmKn
 UBFygsPiw2chFLQIDXg==
X-Proofpoint-GUID: kJCGpIuEA_VkVjZ5dDw0KYcW3K_3-EEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260063
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


On 5/26/2026 3:06 PM, Dmitry Baryshkov wrote:
> On Tue, May 26, 2026 at 02:59:31PM +0800, Jianping Li wrote:
>> On 5/25/2026 5:35 PM, Dmitry Baryshkov wrote:
>>> On Mon, 25 May 2026 at 11:34, Jianping Li <jianping.li@oss.qualcomm.com> wrote:
>>>> On 5/25/2026 4:30 PM, Dmitry Baryshkov wrote:
>>>>> On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
>>>>>> On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
>>>>>>> On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
>>>>>>>> From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
>>>>>>>> getting removed from the list after it is unmapped from DSP. This can
>>>>>>>> create potential race conditions if any other thread removes the entry
>>>>>>>> from list while unmap operation is ongoing. Remove the entry before
>>>>>>> How can it remove the entry from the list?
>>>>>> Multiple threads sharing the same file descriptor may invoke unmap concurrently.
>>>>> => commit message
>>>>>
>>>>>>>> @@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>>>>>>>>                      return -EINVAL;
>>>>>>>>              }
>>>>>>>> -  return fastrpc_req_munmap_impl(fl, buf);
>>>>>>>> +  err = fastrpc_req_munmap_impl(fl, buf);
>>>>>>>> +  if (err) {
>>>>>>>> +          spin_lock(&fl->lock);
>>>>>>>> +          list_add_tail(&buf->node, &fl->mmaps);
>>>>>>>> +          spin_unlock(&fl->lock);
>>>>>>>> +  }
>>>>>>> Is it expected that userspace tries to unmap it again? Or why is it
>>>>>>> being added to the list?
>>>>>> User process can call unmap and fastrpc library won't call the unmap again.
>>>>> In the other email you wrote that the driver can be used by random apps.
>>>>> So... what happens if userspace unmaps it again? What if the userspace
>>>>> _doesn't_ unmap it (although you've just readded it back)?
>>>> If the same buf is unmapped again, because it has already been added back to the list, the unmap logic will be executed again.
>>>> If userspace no longer performs unmap, the driver will not unmap it proactively.
>>>> The Fastrpc driver will free up this list during fastrpc user-free.
>>> It will free the list. But what happens with the memory mapping?
>> When device release is called, DSP side PD is also cleaned up, which includes cleaning up of DSP side mappings
>>
>> Before kref_put of fl, we call DSP process release, where DSP PD is cleaned up.
>>
>> After calling this, we go ahead and do buf_free of the list
> Okay, capture this discussion in the commit message.

Got it, thanks.

I'll update the commit message in the next version patch.

>
>> Thanks,
>> Jianping.
>>
>>>>>> Fastrpc driver will free up this list during fastrpc user-free.
>>>
