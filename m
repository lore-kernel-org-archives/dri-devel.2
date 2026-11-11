Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I+e347Nr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QW4WZCLR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27C210E9DE;
	Wed, 11 Nov 2026 08:37:07 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7142F10E9DE
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:36:56 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KOUT3959025
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 igMYJMq7eF04W/A/XL8oyJAjhaFF7eFiuQ1RKU9QAE4=; b=I+e347Nr8kQrrMhv
 CdfUv6n7OT4zzKr7jAN3iOK26iVfN75BV9KR1z7u7uGfVenCJO59oapm173a/luI
 FfEj0V+4oofjcwJOFv9O7cqlijPcNIkwJwuwLq41hPyBL8b3URmI9aHmW1hXxow1
 pES6YA8Bj6K6bnMsGxxnzWUVtBLt2hZ+vwfQu+Q3cO4CxgCDUzJu4yrKusReoKMF
 yZP4jfl6e2S+RG/P/JE0R2xfKRBLskX4iRc4GywP3a1zaD3S8VYrnr/YiBk923yU
 Snk0zTGuv2dVU1nUwUV89T6DtqnY58TXLkiGrWDgW+od5O3uvJHpxRqAOt9KQJDP
 CW4f9w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b32pj7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:36:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so1750249eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794386215; x=1794991015;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=igMYJMq7eF04W/A/XL8oyJAjhaFF7eFiuQ1RKU9QAE4=;
 b=QW4WZCLRe0xamjwXUlvAzwxMda71DqEqMFDZZE4S2JUurwEtedXxOXKDYv/Odp8WhX
 8QIrkDPE/lXSb/TfD90hnMt/A4Br94ymLUbR7dQofsie/Issek4hQ0TNF36k2Ufhw1zV
 fcE2CKkU32T4rsXIMVxJUBGNRivMgsamFNymxjZozWxRQzvOUGTTGc6gdwVChfImT7Ev
 IrCmW/+/EWFlPnXnq1satC24SNIYnPk3uxQr6y68aGvWzghAO0nXLKhGxBc8asD2RgH2
 K1OPp4IWF14cNy54Huxesf4m9fo/YtNNfkHl4wPPinzWzuH83hUJFagvXtuTxdk0G1DI
 hW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386215; x=1794991015;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=igMYJMq7eF04W/A/XL8oyJAjhaFF7eFiuQ1RKU9QAE4=;
 b=nXbnptdgMfi9W00kljBHbDKBrEUBOs0HBZtiSboKL4QMbe276tGjoodjX03NAuUk+P
 aDjR18eDnFmT+ICfs9pwPsh0gsThgmTaAvKRkMUsx8Wb0CHg1CXkYTyuTW4p93imsGpq
 ZPXeziUyaYDOLuH4MGWvO64riv5pvD40YXfRHTs+3KMo6k7+FfuIDu+qbV7ZYdCSBK3j
 X0rm/HZ/waZe0HoRQEBp3VLvJFwDn/au+Dc4GzA8KVO6ChLp/uLOZSxO8+nT/qeH4PcL
 6JNt/EK64EzeU4fTQBAnHF0qBJaQNx0HoF7VFv+TxKzasisVI/oQBLBc8Zi5TgSA2XTq
 twGA==
X-Forwarded-Encrypted: i=1;
 AL+hErGS4LXfWhQ3vIdL1YutFyMGkd45d+QbqMcG73fVYmEnFjCkWp1hcO4Ruw2IkpFjK/lwRb7UrKWl9Fc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8LZJXBndxKLiwwfvsk6aU+L0LDtwvNyHzttHaRERCzdDjJ4cPv
 +FvQ9N77yGzUxtLa5j+5AXaHKj3fvg8Rj+R+pgEZN9jBBdvSKooZnkksGT6K6gHRqMeG0t6B7BH
 cMeanSnGK/pjyHkfrL6fQXLIDnG8bwwcTrq/scA66b9lmp1aMbc5AMXhZNieSrSO16Kf0P1DQng
 Rei8E=
X-Gm-Gg: AYBFou21WVIcvLgo7acyyUciCDkHy3a2PX+u4nwQmpuINNg/CgdMKXu7di/o6208S3y
 LCIgEIeWDiu+3i3P4y14OZzWjpdFtgTBNjFz5klfjuVOi2ux9x88lyxe4Son8tc8WEgScqSsIYz
 z/YSnRW98RK8uLxl9yAqh9jHE/6L3qJJO7YFpUSLb5TOKssN2sW82WJZRgo0A9nh47AvOWgRVB1
 hNPTqk64+w9dBkGA/9Ta/3GuJJkf9QVt5L4J8foL0+DXwPp1RXOYL4ZHgFnwllKL8Ly+EkwQZik
 TupRRNCmmWQLN82CYa3+1xEQiKb8xLUNOYI4hCFwIz3cEgYv4IImb1uUj+lnqBatp3KUKi6ujay
 dQ+slNpO5Xr7mRSYFxLqwwUfpOokCj1VkH2kInLrvVog0/OronLCjDixkkxuO7hTmXeMAcoYjHA
 MSB0U=
X-Received: by 2002:a05:693c:66d3:20b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-37683188881mr2370139eec.5.1794386215137; 
 Wed, 11 Nov 2026 00:36:55 -0800 (PST)
X-Received: by 2002:a05:693c:66d3:20b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-37683188881mr2370118eec.5.1794386214630; 
 Wed, 11 Nov 2026 00:36:54 -0800 (PST)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe306e3sm14498936eec.7.2026.11.11.00.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 00:36:54 -0800 (PST)
Message-ID: <a723688d-5a23-4ab5-8cee-bd4b6dfd8aa8@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:06:51 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/25] accel/qda: Add QDA driver documentation
To: Daniel Pereira <danielmaraboo@gmail.com>
Cc: srini@kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-1-88f2f24a5f0b@qti.qualcomm.com>
 <CAMAsx6cNcqHLHHgS5ZxvnK2fjrV74WmsZ+8peLvu0gwPjFr+6w@mail.gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <CAMAsx6cNcqHLHHgS5ZxvnK2fjrV74WmsZ+8peLvu0gwPjFr+6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af42927 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=qPl2DjZev0XnbMKBJ24A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX2ThXHR+p1BOf
 Fg3JMRXzoQMp3XjTvvNXLRhHX3LywehNAydOGcwQBta2Y3lh3syFzcVJYyalUdpo1O1ADxri5xI
 CFzrnQ/VnrTZV5Pv/VRR9+LIRVwmmD71JuUtZifH8H4UQTrHvIeTEZKqy78RHRH+2PPT64x0c7j
 QKBR55xhwnyIV0C8r8ax9zpDl3AmYZX+3BRxr/YjF5N582Cmy6VKlN1q97TKkovrTNzK99yC3hz
 tDpPq+KKC032aNZcb9AOC0mKygNk4Maug7qpCt48/YJwZodFY5abuhbXGcozEuuHTLW7JiS70uY
 pq4p8asCwsAd3o0BVZ8ES6laR6teYmzrwc2K4LHDB3zReAI++4fOrKCW3aGYkE+H8Y/4ulkZaHE
 pBck44UHb63MQ6U1D4bCJBMWF8hreqYVz8qfQYL2ieZHQmQiaNKFJbr+Z77xRZ02phuePLtYTNp
 I3BrpJes6kYKM8+XlIg==
X-Proofpoint-GUID: 6OlIaOfJc-KlxemIk2BqbM4rgoXYGqhN
X-Proofpoint-ORIG-GUID: 6OlIaOfJc-KlxemIk2BqbM4rgoXYGqhN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX4UaCFF2dz4C9
 Hgn1itQQ4lp6VEoxlvqttc8tLSGBEdwTZKGxfm2H4ofiiP0Em7frkX9mGLZTOb5hoUbRLNpDh9D
 vMVjqkDZcyAvRafkZng4hvImfSfrll4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110034
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03-11-2026 19:49, Daniel Pereira wrote:
> On Sun, Nov 01, 2026 07:37 PM, Ekansh Gupta
> <ekansh.gupta@oss.qualcomm.com> wrote:
>>
> Hi Ekansh,
> 
> The document reads well. I only have a few wording and consistency nits:
> 
>> +The driver binds to the device-tree nodes described by
> 
> The kernel documentation spells it "devicetree" (no hyphen). The same
> applies to the other "device-tree" occurrences in the file.
> 
>> +4. **Context banks** (``qda_cb``): creates a platform device for each
>> ...
>> + They are created before the accel device is registered
> 
> "They" is ambiguous here (the platform devices or the context banks).
> Consider naming the subject.
Thanks, will fix these.

> 
> Thanks,
> Daniel

