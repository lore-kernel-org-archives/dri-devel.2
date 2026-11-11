Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAD606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G3MTb9Y+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eU0jvpI9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7722910F967;
	Wed, 11 Nov 2026 08:35:17 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4324E10F967
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:35:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5K8W91408970
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +AtNonFM71vbXHQV7j3ip4nyJfhO59wdnq4MfPfi1bI=; b=G3MTb9Y+8weOGt9Y
 0+2hSI46Wr9+Kwaj1870IOXSx1KuhQOGseWxevW0WyhgVw8JBLUG2173hWJj4OEW
 SHDGiOZsFx65l1TAU4ZmhIjNGzBFh68P8mW2IaUPqq4ZA7jdV8tVgdjZwEjw7e6i
 7riyufEhiwVMl2YbnQkGk2peswmp8dJtiOkc2ohko8HhjjZMSwMhSThbEFgvdPxC
 kWJTzxN0DUJ7vwdeerFRkDPPFpayGrBrunj6h30UpPUfay7A6PzJy4NYhC3bubv+
 D8uvY9d2+8itGgJXtEs2+RwMd6H/ZDeQJyPcClfnRuiNelMcSB5K8mnmDZZWIAZ1
 A2vm/A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdh10x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:35:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so3925871eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794386105; x=1794990905;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+AtNonFM71vbXHQV7j3ip4nyJfhO59wdnq4MfPfi1bI=;
 b=eU0jvpI9dV+m/ARdPweIg3aT3vWBjLwYjs6mKFiMYBKTY6njk4Vw936fJ2iycNF5Jj
 aHhEehvJdyyLzPtPbkIUdVNCmZEia83x5q+rwn8wlwwgpJPh5eJWVgRBCmdlzaBGuuAH
 EHYVx3E+Y52GSyPQ5rnH4RXe5VEXiSZ5Dh87g+5Ksu02J8jEP7DYLAFKV3DktiHSr61J
 JBS6eLOmle8bYEYpIB2ONFAQvd7WWATCJtVfcufheIN4jFKJlKn0K3oj+Zkfg+qYf7oy
 SPKUstyyL6GdGMswXBDPAFbs/2whiR1JrBjkn2P/SnFqEuxY9+UgjssPFv4wdNI/7ohF
 O9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386105; x=1794990905;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+AtNonFM71vbXHQV7j3ip4nyJfhO59wdnq4MfPfi1bI=;
 b=Pga93Pd4rzdkfSA2o3/oGqw5j+cP9o59jjLG77gnSjVfVC0e3gEZt5GRAa6OgXjzYK
 SnMUYnAaCglmZL2V63BAfnTP+ZU6uhz/msuCdI6gGXojhnWK8xj42aUfRYp7+Ujt6maI
 hdspo0rKIQiPddBTY4MdYD6+VNXCXimlV9l2+S2j6klqkMVhNF2hDJ7OlfrMhN5A+XvV
 MjE6Ctdpg+IafmEksrFHR/da53tprmJMrCUaRG2GeSLZXaJ+B20O4G3mvpUBlLpu2nS4
 EI+0UlJamkEGfnAh/iMfC56sDVdqCJcOw9f+sS2os/GmTqDmBvSFiHFArxPqZWOwtAGw
 U9xQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE9dxKe/qixdoQ2QDItrconNLAK308FIP1igLBTVpNkTlO7IPbdpeivtGyTu4Ryuc9aGLpBr0WxC+w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z89957sPve2pnALamaCz2HO6j0Oi4DjuvfxALJfRmXQPHRwYwbc
 NQ3TATWYCShQKiHWDJJNheTL9BYJRmqstYNln16+EMiE5PMmawcb5iNVB3PPQqISjWbDJ8kiVh0
 d1CuktUokt0bCwB6EXmeXpLhthS1DWxFxNNSvS03YiHb2Jr+LhCMCB/sisF28rzaH7Qsl/Bw=
X-Gm-Gg: AYBFou3K6aQdz77eGkAQiA1GmHNk2ZzNlZlXNV4dIadCy7adw9iJGFsn8o/8AmruX6L
 fwA50wixI6DV0q64tkr9FHzaqNSSOdK2zKl3GGGEIgXf/hMe0xAK+SNtITUVnjlwX7xh6509Amj
 HSRwDvY+0jwIX+CDrdXqpr37XHMaH+25BUkX1ZlixCiUlug1BR0QCssuAh5a5jbjpMq5R/xHkgV
 vd66vOY82zsfa5fa+t6+sA0HOUGDbhR0oCsQMtyiMWHiSRBRR2Jw3snhQHr2F9rI3m4zCgnD4uT
 SpAwisi5m367x9S5aGIk5pXOsbxC+lOH6nRkW3+CCke7PbYjqr/AfI0dgKH9xyozCru53Tk7Bxz
 lV1C4rV2sXH3UypMZ01dMPBUCFD+t2lr+WOJvXGxH2nMjC61aqTzdAyiKmwO1OaLPPgFiV+sc76
 tFnL4=
X-Received: by 2002:a05:7301:5f01:b0:35e:2c6:d46c with SMTP id
 5a478bee46e88-37685b80487mr3633527eec.10.1794386104857; 
 Wed, 11 Nov 2026 00:35:04 -0800 (PST)
X-Received: by 2002:a05:7301:5f01:b0:35e:2c6:d46c with SMTP id
 5a478bee46e88-37685b80487mr3633472eec.10.1794386104118; 
 Wed, 11 Nov 2026 00:35:04 -0800 (PST)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e7d24sm21766474eec.22.2026.11.11.00.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 00:35:03 -0800 (PST)
Message-ID: <0f24911e-83e6-4de7-9af9-3c1bd3e143d9@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:04:52 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/25] accel/qda: Add compute context bank devices
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Srinivas Kandagatla
 <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, rob.clark@oss.qualcomm.com, jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-3-88f2f24a5f0b@qti.qualcomm.com>
 <492ed183-9495-401e-b678-e91a324f5a64@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <492ed183-9495-401e-b678-e91a324f5a64@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af428b9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=_YfdpRd3OS4PFdmd1n4A:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: snUtfPs3OdsL2LaJrnmi-LjmG3VSYUHG
X-Proofpoint-GUID: snUtfPs3OdsL2LaJrnmi-LjmG3VSYUHG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX0vaTK+YaR/Gp
 Aj2GRdpSwWHljhRNKbntZPeLPUHVj/CDnmBrfmaTZfqkUVVICjm0RKK9RreU/eHiQIP4oLiSPmD
 qViLpGoeE3g7rdbd53wu0zl48uonPfrn0alFNeRlMtAXDq5uraiYoS+R4mdlcJ8c5H1owM0ZInE
 Hmd35koyDqbjF1XZpeR2o2wQlL0ofQlW57MZfUdx/yDZnLf0bdekzcPQvzH3hOVXvr1u/MyTON0
 7ncQEkv53LbV9O4wGw5wFsQE2z1FaprCXUQfUeqQQRepb0po/Wa1OOepsqzdLtsT8Swy8KqP9r1
 wFV9zQJ3NrsOkK3I2re3wIsF06xJh9p7HCR4IT3FyWshSBF3r4jHuVoLSIEc+aY2XZ89DhhG4BV
 aThr7f4XYAXmFAs0DSl2Eqy77QteNua4eacnRiSBWpTsIKUeW4LKtFr6SQ/7IffFQCswVIm107i
 4yEqksee9XI559rVtog==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX6kZvx95md/JY
 tkQw94BrcNE0HauvGowZuSm1Flx+DcJjsCWoStMHAzgYyVmxTEq/U+MdH8NAyfaPW3x03rj0cnn
 gTUxubYg09oN0lTunkkDkprGpwZyXuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02-11-2026 14:13, Krzysztof Kozlowski wrote:
> On 01/11/2026 23:21, Ekansh Gupta wrote:
>> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
>> index 6bd977e8d68a..78b5f31974c1 100644
>> --- a/drivers/accel/qda/qda_rpmsg.c
>> +++ b/drivers/accel/qda/qda_rpmsg.c
>> @@ -5,18 +5,18 @@
>>  #include <linux/rpmsg.h>
>>  #include <drm/drm_print.h>
>>  
>> +#include "qda_cb.h"
>>  #include "qda_drv.h"
>> +#include "qda_soc.h"
>>  
>>  /*
>>   * Both compatibles the binding defines are matched here. The glymur, hawi,
>>   * maili and nord nodes name "qcom,kaanapali-fastrpc" as their fallback
>> - * compatible and so are matched by that entry. Per-SoC DSP parameters are
>> - * attached as match data by a later patch, once there is something that
>> - * consumes them.
> 
> You just added this in previous commit. Why adding invalid
> documentation, which is immediately removed?
I'll fix this in the next spin.

> 
>> + * compatible and so are matched by that entry.
> 
> 
> 
> Best regards,
> Krzysztof

