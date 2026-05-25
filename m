Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C07CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C509610E0EE;
	Mon, 25 May 2026 09:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FQw2kWZb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uul8hwFp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A3610E0EE
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:37:32 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P8FovM3241878
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LOQIvvm1gvabh9O4nNnnFAMEBC9uqf0uaqK5rtlsLZE=; b=FQw2kWZbw3beSEaZ
 5QsdI4wq2NGPeMRVlD4hEz5GazUuS4huUnsPmJdvHIRiMRCGL9ZSVwVB0NVmeHRx
 wVEMfDDjlNtE8vbCi6X16xfgjI4cfUCzPPzQJmBspGNKbYIg8bzOJNg6xby0OcPv
 HZTAoW06dxlrNnXFnLN5UtDo22m880Fij6WAFEK/YigLY+cL/0mVgxcjuoxXecmf
 ZJjC8iSpEKUOFvVlk3ZnhAd3Odiu6acPuazbbc/ZaZbo9jRkVmd/F6dh5EBvVdhL
 xqnuauzu761unPAlEXBABTjOhiGSm7PwK2KIRrMkz2zafgRmEG5H5O+w0UFV2XgP
 Ez55ZQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asx3gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:37:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8292a9605aso4461701a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779701851; x=1780306651;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LOQIvvm1gvabh9O4nNnnFAMEBC9uqf0uaqK5rtlsLZE=;
 b=Uul8hwFp5Avs4Y4Pb865f7nIY49KfNymopm/FNfkYw/TFBNl75ClWQBTQQzD/GEEwu
 OuiUEDXlIs7i2OIkUp+KDxUaISq2zrXj3Cziu1fJyCUR0kJWk+s0LS1WY+hB698jnMA4
 vUJKm5tlgjO9Brrmdi0mNvLuOe6hECENn2muQ3BA+/pQ/bdZgsOmMjoVswIYgv9Zbn9C
 xymNh89crSC5LTcJ8FMez/KmzyJcwZFJnCGIH5Q27mUu5Ou+svVXB5HTsLS2mRhaJpk1
 NqL0srO+jY4t1uyqNUtNWkw0U+P4RGLe0NHepV6mWo7+ZoLnkhn64L0eLcxp7rUUcQ2v
 Cr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779701851; x=1780306651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOQIvvm1gvabh9O4nNnnFAMEBC9uqf0uaqK5rtlsLZE=;
 b=s/EDI8SexlDVTX6oj5ZLnz2468buKbVM721lgab6/Rd4jH1jHuzpTb9CLZpXMq7ljg
 r4f/DXT3XEoqfteD1rOEVpVgkOer2orD9N9kv2YohO8a1cZScV+hvvQTXQVs8m751hYb
 PW7EdhtFPsONwsgilQ0RRjM50jUw92CHWYKBqdsnQeLwVSbha4/FlY3MN9wbgaTp1C7S
 wYK8+9cus1KigFJ/M86UE5hCMGM3om+LtZqc6Kzm9nJBkfgx6FdmLFCPxuuuDkVLe7dO
 z4UlTcoglqhnYDmi/XjJ8EPpjXe4lCKx6AwVM3TUPph2wo4FZYdbl+rwEzvyiqbPrGL4
 Lh3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AQq+3s9q0/UU6SzehyQjlu55Ubm5XFdABvy/O9oe1UDmmcgyvrQLGNF37tGf3u6+leQ0AqaJCKEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKMBBgCKjJl7XZ9jgt9qVq9eywteF24mIyCv+mgDfu/oONGQ9q
 t7NOLUFMo7kBMwLpizOJHqd3KLhaAwkhOQVGE9QsRXcnp35b+3pKQRzu9RUR1Y7zsYe2uZJVy8M
 TuYsvoaLXKleWcS9SgpjobEAuB/C5hktU5cz2wzPz3rOuLwRireWMNe4C6Rt37hQrwxC8Q55We9
 jGPREf8A==
X-Gm-Gg: Acq92OFoeaBampqZH06QNqEsqMPRMfGxLrs2fJiWJWTfzKKHWoLFa5+oU7JTi/nPvyB
 TEsFZqUrfIS7pwMnzAvSZ0c19txFTkTQZlfCcLrEFlDog+S2g5/lrstr/387jyF5Cjo7u5eFsCL
 G1evs5UHD6z31DTI5gj6JgfZiFi/sVmJ53saVeQuw+YYoKHwS25m8UZC/U6vjlLopvG/YXC3mQl
 0TTFyyKcDNG77gAOxYnrPejs0ylLJ6NEQplvCRDiHT43m2jcyQ/9Ljy5Ots9wgSd29Go5dnEcDs
 jdNv4fnhRy55QFVVWX+6AgZaGqIuSFeaxnER18pny+8iXD01YUZlSaz8Owp+U1o2KhbNylPZ867
 8y8g7Q0YuBbGZuMAMJ4K37JFhjs9HrJV2MGujZL2Yx96yYw==
X-Received: by 2002:a05:6a00:ad8a:b0:82f:6e7:152d with SMTP id
 d2e1a72fcca58-8415f1a06fdmr12494022b3a.21.1779701850594; 
 Mon, 25 May 2026 02:37:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad8a:b0:82f:6e7:152d with SMTP id
 d2e1a72fcca58-8415f1a06fdmr12494008b3a.21.1779701850131; 
 Mon, 25 May 2026 02:37:30 -0700 (PDT)
Received: from [10.64.68.239] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fb3083sm8990026b3a.43.2026.05.25.02.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 02:37:29 -0700 (PDT)
Message-ID: <a7b4c0ea-0e02-4ede-8d51-a4c038d55a5a@oss.qualcomm.com>
Date: Mon, 25 May 2026 17:37:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: misc: qcom,fastrpc: Add Maili FastRPC
 compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260525-fastrpc-v1-1-ae9add881952@oss.qualcomm.com>
 <meuxtcs3quchupl6gf4vtjiosmoig7zs2tc2vr2xthetem5hll@l4op77zr2srj>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <meuxtcs3quchupl6gf4vtjiosmoig7zs2tc2vr2xthetem5hll@l4op77zr2srj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5OCBTYWx0ZWRfX/1PZbdwm57iS
 WsmbPmvgFoGIr6cqJ8iS2bbGVwN6kSY6RxkPnOZelFYVJdKXkaQKvqw/Fv7L6pg3PMPNw27tQUg
 vnu4vyxkWVCv+F7FA2LZWrh7YAjW30WA3RTuxztrF8YcWxd7QGHgswdsKzPWnMD7PwfGqBAYpLl
 5HZMtLVkijWfhmYNkymhNg1K0d5SZXp7oAaOTDELRJlXYrp5bPy7+najHBWFAmRx/PMp2IJNYtw
 fwbStOAyc/0MbSBeST1U5h1sDZXTIBCXl1cdCuUxSjEGTCgIJOZCCUKEM/KSNbahGNR03fth/ba
 EmF21Qv1Q1QdWEiXEi9NpAKZ/3XBe2CLa2VAwEGsmhgkJIVll1x6ZRTW3JQW0ibH3nH9hKahWl1
 GD8YV3E1aNfGOomZmWsOFWe8QpQt/EV8c7zsYZSZVtc2zp22Vs68pIQpz5JCgnb2UbNGxG9wS/t
 zIoA/LupZ6l2kXdmy9g==
X-Proofpoint-ORIG-GUID: X1H1GF9alX7EyAgqfDdrE6KUk7gzPG5G
X-Proofpoint-GUID: X1H1GF9alX7EyAgqfDdrE6KUk7gzPG5G
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a14185b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=in8ZqU4PNEo4w4k2-loA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250098
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



On 5/25/2026 4:37 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 02:21:17PM +0800, Yijie Yang wrote:
>> Document compatible string for the FastRPC interface on the Qualcomm Maili
>> SoC, which is compatible with the Qualcomm Kaanapali FastRPC and can
>> fallback to Kaanapali.
> 
> Can I assume that it has the same bus width as Kaanapali?

Yes, the DMA width for CDSP and ADSP is the same. If you were referring 
to something other than the DMA width, please let me know.

> 
>>
>> Assisted-by: Claude:claude-opus-4-6
> 
> Claude assisting to write a one-liner patch? It's becoming ridiculous.

This patch was generated alongside a set of Maili-related patches and 
was not created specifically on its own.

> 
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> index 2876fdd7c6e6..afe52296bf1d 100644
>> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> @@ -26,6 +26,7 @@ properties:
>>             - enum:
>>                 - qcom,glymur-fastrpc
>>                 - qcom,hawi-fastrpc
>> +              - qcom,maili-fastrpc
>>             - const: qcom,kaanapali-fastrpc
>>   
>>     label:
>>
>> ---
>> base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
>> change-id: 20260512-fastrpc-9f3b691f8e2d
>>
>> Best regards,
>> --
>> Yijie Yang <yijie.yang@oss.qualcomm.com>
>>
> 

-- 
Best Regards,
Yijie

