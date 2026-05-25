Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76EECD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FA810E41C;
	Mon, 25 May 2026 06:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IxpjIjhL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UuZ97plH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDA710E41C
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:50:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ONE3hZ877595
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IXgwX/BN+Wvydg0Bls4hK6tR
 Lkz7ypU2uVd20K0LfNQ=; b=IxpjIjhLCubUIy9/OlDq3DZxdVxW4Gxz+P5M9wB0
 rzEBv07wYXDssVo4EOfDW0+XAgD/i+KjosWIdkjn9bCjYNX8dYMwbf30uJchURzh
 rJHiB1zVNiL5Xw1Jq3MO4Bdks2bSUha60rEsRosokoUPqNEQ7yKNa9Qm3b9IfAY2
 VxitltmpoN44cAwupbMe/2hrgxZeIKh9e31x3JgcJt6V8PwD1RygfcJ3f4tbBjEO
 E+tAPY4snhTME8pbyD9vQVmuJtilkBu5KVCalI01UCh8zgt/mh0XYty9zGQbFg2/
 PDimgj9zjtIpYpmz44Kh1PoN2ndhnsViOQ22lPGKMyC8LA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3dcff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:50:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b9fe2d6793so207964065ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779691815; x=1780296615;
 darn=lists.freedesktop.org; 
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXgwX/BN+Wvydg0Bls4hK6tRLkz7ypU2uVd20K0LfNQ=;
 b=UuZ97plHNoqBG2JpBbtb579CVAle1M4hPtj0qNpq5IyWvxtlS2AarSZsewSH792M0c
 fVp2oU3Eo7iIN1w1/CHljSu3Qp34sjbgHZOloZrXKN5uOLaYeQXyun4j6E31Xuy8VZDu
 egunC28wt7vyxXX1IDa84xg+SYlupSK7j4y4wIkKgzzpDU7Z+e8nCGGBiH6Sg9bamyPe
 fsEqR/hqvnLSKIcL+zECLLEkIJ9xALXXATQIva0UrgudCGs/CHUJYhi4gEJv2xhUSsAx
 Yhj2pavVT0lMRbg0ls2twqp+hzKWz8f4HC102V8T8kzJtsITBUtk+G0DJuOCT9kKmYKI
 K8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779691815; x=1780296615;
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IXgwX/BN+Wvydg0Bls4hK6tRLkz7ypU2uVd20K0LfNQ=;
 b=DWrFxmq9ALy9Vi4z/STxdQvoKGsY7qr1rhndz+ZVN8nGCXeUJU91XZs/VFa+r7d+SY
 ABOMkq5MdUhD94M9dSxXH5s65nEPkD4cNTyKi8BohnFp0eppS7zlEqSpmdWcLS50vdHi
 KV89Nbkbcr/ftgQhinV1AIXGdQiik3Np1udNUeMPP2aVlpMOqGL4OOwoZhEg0D7Xd7kc
 W4CS+ekEZNRS+Kka0qWGu6nUFQDXZs60jcp8gw/5ZaHKaKFEZ6e7TDiBv8hBfUjpl+vm
 j9jgg82AhTZO1SJa/etaa7Qd10JtrhcQ7UOe+prbtELpXlYuOFlSsbpKlj1ujYQ/Ivos
 ZibQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gR/Sb+HnbPZ8paVyp0/Emh353ESEL8Qnc5VVul883dosOCZWU1GVov8sDmO/UguygCUODBG6mYL0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDqapC7yOiHy4tEGDLYUPczLPAYB3sWKxLiDkHUYAfKid/6OY3
 fsbHcrgOdMKRDZ4BXXXue/TPJ3niwDJSN5qsO+VooHABfhol4b1StIhvUNzSQ3T0Q/OSS/0Hanr
 O9Ln72ixjI7yF+J5Rz3zdItBmR0bpDSu5mG3Y/UIsgr63wOsFCGYxI9/Nu/0e6Iy3WHbi+Ps=
X-Gm-Gg: Acq92OEFnXUM89K1YAWB3JXA+0FQVE3OcJJ4ylcD/Z2flO69za9Y23qfzCjGXEJg8rP
 RKFb8kbCRB0qtSLOF8MTWZN7x0QcMUolM6WJ9EBsEE8B0Q+N4C1QJaViI54Q+tPVanbV/Kys5B6
 0WAhyvL7pQGldTaM5nMntj/URLTuAvwrcwzVOFpUltnElmq26vYjylkTngtty9C1wGgLD5Vc84r
 Vkh4++9GDQVbhvFkDx0QoBBmIOQA0jQFBBs7l1mfNadt22q58zQlnNWprHK2cdWvu9NGzzbnE8p
 5hna3NUup82L7HiF7Z5/Tx5TT/1/w9uBSAkPzep+bzwWIOxbOvszfi3KJGsOcOSmoybHttEhSgv
 RaTLumqPWgM9dd7eDxZlJFVdBtLwbcfjWdrYZs+FZbKZGLDdosaIoEWfhtrEdnIJr2wKKNNDEnk
 t86dzVcKkR2tiz0feciQxlmf0Q9So=
X-Received: by 2002:a17:902:e745:b0:2b0:6a22:5165 with SMTP id
 d9443c01a7336-2beb0631a29mr143935885ad.7.1779691814995; 
 Sun, 24 May 2026 23:50:14 -0700 (PDT)
X-Received: by 2002:a17:902:e745:b0:2b0:6a22:5165 with SMTP id
 d9443c01a7336-2beb0631a29mr143935575ad.7.1779691814464; 
 Sun, 24 May 2026 23:50:14 -0700 (PDT)
Received: from [10.133.33.209] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695f5fsm86076325ad.8.2026.05.24.23.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2026 23:50:14 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------5AyF6PH8XKarVpt7ZLz3e99f"
Message-ID: <fc638116-2b80-4610-a20e-31baa6881774@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:50:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
To: Greg KH <gregkh@linuxfoundation.org>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
 <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
 <2026052211-pavilion-compost-5fcd@gregkh>
 <d9248bf3-ef48-4c04-ad7d-debc8854bae5@oss.qualcomm.com>
 <2026052541-moaning-dioxide-d5c7@gregkh>
Content-Language: en-US
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 amahesh@qti.qualcomm.com, arnd@arndb.de, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, Ekansh Gupta
 <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <2026052541-moaning-dioxide-d5c7@gregkh>
X-Proofpoint-ORIG-GUID: J-wk-4igETHbRal1jMM-TWIibWYLEfEN
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a13f127 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=4N7uJnPDXdwvaSyrK_AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vdeD6H_HsMhiC5eImKYA:9 a=FOgTHULqtPVeTiFL:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2NSBTYWx0ZWRfXwnpEsYlrQO11
 Nyjp60aWh4uTf5fCbD5b0k761PWiSgI2odLrGzCrSfUJQr7oC6Li4ulzySCeDE6bpBM5463XTZf
 KljKPLDH+ffh8DlMhkleyP0H9rTMSeXsklvCmxyM9xAW8Hf2yW+xBe/mhZrZBNLTsE93xcyEN+l
 fpi9mFLkGuj7bpoRWKo7+l6v6MxMMBqeZ7ZD7krywiNQmT5fOpY+s8Lh5o+pjPkBeYUkAeamTiB
 fSt+/NukyxuxQaMsHqB1AEhl9e81c+1TnR4p+UjYDkI4McMKOkfwpyG7c4N1EKqaQ3Yij24rPjD
 m7XY32b4yGzKNo1A3Qbgc/3L1CyyznL8b9BEEtkN0nB5HEWjhendk9PbODDfOFzggicW1yCOhZ7
 AMhtCZ4bMTilBfbcqzyDo/TKqaWxPSVQvnf3bNgGRWbaKnDBBcS9nVvKqI62aPOYLvQ7RjzGqmZ
 uIttENncxKHmVoEnsYg==
X-Proofpoint-GUID: J-wk-4igETHbRal1jMM-TWIibWYLEfEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250065
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

This is a multi-part message in MIME format.
--------------5AyF6PH8XKarVpt7ZLz3e99f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/25/2026 1:06 PM, Greg KH wrote:
> On Mon, May 25, 2026 at 11:30:43AM +0800, Jianping Li wrote:
>> On 5/22/2026 3:03 PM, Greg KH wrote:
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
>>> multiple threads sharing the same file descriptor is a horrible
>>> userspace bug.  If you do that, you get what you deserve :)
>>>
>>> thanks,
>>>
>>> greg k-h
>> I agree that concurrent unmap on the same buffer from multiple threads
>> is a userspace bug.
>>
>> However, the fastrpc driver is exposed via ioctl, and any userspace
>> (including any random apk) can map directly and then call multiple unmap.
> So there is no userspace selinux permissions settings on the fasterpc
> device node at all?
>
>> This patch is not intended to support incorrect userspace usage,
>> but to ensure that the driver remains robust against invalid or
>> racy inputs.
> Isn't control to this device an "admin only" thing?
>
> thanks,
>
> greg k-h

Hi Greg,

Thanks for the feedback.
Yes there is sepolicy.

I’ll collect more details around the expected userspace model and
access restrictions for this interface, and better justify whether
this needs kernel-side handling.

For now, I’ll drop this patch from the current series and revisit it
with additional context in a separate submission.

Thanks,
Jianping

--------------5AyF6PH8XKarVpt7ZLz3e99f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/25/2026 1:06 PM, Greg KH wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2026052541-moaning-dioxide-d5c7@gregkh">
      <pre wrap="" class="moz-quote-pre">On Mon, May 25, 2026 at 11:30:43AM +0800, Jianping Li wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 5/22/2026 3:03 PM, Greg KH wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">From: Ekansh Gupta<a class="moz-txt-link-rfc2396E" href="mailto:ekansh.gupta@oss.qualcomm.com">&lt;ekansh.gupta@oss.qualcomm.com&gt;</a>

fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
getting removed from the list after it is unmapped from DSP. This can
create potential race conditions if any other thread removes the entry
from list while unmap operation is ongoing. Remove the entry before
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">How can it remove the entry from the list?
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Multiple threads sharing the same file descriptor may invoke unmap concurrently.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">multiple threads sharing the same file descriptor is a horrible
userspace bug.  If you do that, you get what you deserve :)

thanks,

greg k-h
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I agree that concurrent unmap on the same buffer from multiple threads
is a userspace bug.

However, the fastrpc driver is exposed via ioctl, and any userspace
(including any random apk) can map directly and then call multiple unmap.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
So there is no userspace selinux permissions settings on the fasterpc
device node at all?

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This patch is not intended to support incorrect userspace usage,
but to ensure that the driver remains robust against invalid or
racy inputs.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Isn't control to this device an "admin only" thing?

thanks,

greg k-h</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre"><style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style><div
style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px"><pre
    wrap="" class="moz-quote-pre">Hi Greg,

Thanks for the feedback.
Yes there is sepolicy.

I’ll collect more details around the expected userspace model and
access restrictions for this interface, and better justify whether
this needs kernel-side handling.

For now, I’ll drop this patch from the current series and revisit it
with additional context in a separate submission.

Thanks,
Jianping</pre></div></pre>
    <blockquote type="cite"
      cite="mid:2026052541-moaning-dioxide-d5c7@gregkh">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------5AyF6PH8XKarVpt7ZLz3e99f--
