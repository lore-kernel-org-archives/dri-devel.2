Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FA7C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB9F10E6D7;
	Sat, 12 Sep 2026 10:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7en1+ye";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OcBaRB8X";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB7010E6D7
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 10:44:47 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68C85Ijb2664845
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 10:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fKV0GTN6613u1fd+fPAiYoVn
 MV+bi3fMryJz6bPT2XI=; b=m7en1+yeuxqFPavKn0xOhSqdfoDS1mO8tbRjpENT
 jqzBkelJ/7n+mp97lKCjsu8NFjdMFwLpOBHWsbDDmz6nbsv0Q69js2r7NI8tjBJB
 wOUfhMcnvQQ5tSgRSyG777cG+KHxKHlkuQlcF/pdU2X+XUaruE52M06WvFCAWhY8
 SVsdG6nndsOmBf6hFgDRFk/AbO5PQqucLvYCFbclwvT/gnCkGU93VXT+yx8LAhYC
 //kJRX4uYgz5J2YG3KgKoEyWbTm7jRpnPPY3jDZBe9sL1g4c99tyfyNJJ9er21vK
 vCsnTytkOx/uPU1I4aq9ZqQqy7IhYBQBpj6emP88snwDEA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c8re0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 10:44:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so3437714a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789209885; x=1789814685;
 darn=lists.freedesktop.org; 
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fKV0GTN6613u1fd+fPAiYoVnMV+bi3fMryJz6bPT2XI=;
 b=OcBaRB8XjQzHMXACaNxc+3gJ58hlZoqj6Hd8Z0uwR0awwKdehIWsXBe52wCR7BkbI6
 ToIJl85r38peR8N8sPdzh97jTes8pwaBxsk5eK3xBlSbiAFtunJG9cOGvrU9J9SPSOI7
 tUyALXZ/4Hqytd1gJX9RLO2zXz85ODTy/OmnnffrD/Ymi0/SsoYc1e4cy6QNlbBFJI2Q
 mU8YGweFlZWAUsPXnJ4q8knDCFL4xT+NCKxpHY308hCC8b1gWikfw9tTsgTmvqVnloX4
 eN2WvvEeZLRyEdRBlHyzuRJaLMP63k+zOctRR+SKaGYTDO877R8AnCGeFV/8/Ttq6AFb
 cEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209885; x=1789814685;
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fKV0GTN6613u1fd+fPAiYoVnMV+bi3fMryJz6bPT2XI=;
 b=Te4EuiIDA9ALyg+bu/qaRSH2Yk+8CTdKkh2zYzI+ZFzIIqFK6TewQEyuHKOHcNxFvI
 MARlEU7OLmGBjF/n3TS7DnoH/ALIqd8EqDrCrlZxcviiOVG8O5In4GUyXHIe4jn1sXhZ
 CFP5oj3UQuBpyC0/GDMnfen3OyRLBdu82HjWim4CCsebKGeLewFdCm/NuuBJLFRqWbMK
 H282u3fXH/mGWTeIsiMQlcS1/p1n95rhN6eLO2KxnFd/xEGwItV8KroyTKrG4iIBgdN5
 DGw01mBtTKPDPCnJm3W8ry7M7gmxlRDYDkoXGaOH45hDNPGnUWgqGaGoeu/1LPo0zs/G
 5CZg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKqFeJPooIfDN4rGIWICOJIU+5Jq4xkcuDpgCy82iV7cfM5fT1XYLYz12r25I8ifY4eKaLe6xzSd8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l90JWdU88fYAdYNBnQ0NBlVgka2aJiY6Le+IOa2+CyTiuwf/HI
 ABPO6E0gJTjWLMJA9xDx1lNE63KPgU8mi6WOhCHNVfEvXTac7mgSxJ+FNG1DhzBRZQylqHdiKxg
 TuHQRQiNi/vTvatRT4MyEnrM9jtP6Tpysj47YQwAz6DL4j+J5TxCLTOJwOA766l94zrTunzg=
X-Gm-Gg: AYBFou2ijspiWde84vnulSnzMk305k0iKMUICnNqmqpzlI0P5E0hgpp1z+oo2Wt8i1r
 QMLqKuQS4s9GVh/06y5Yvw+5/iNXcO72N75Q4PUacqRgk309wQ8/O6RWxa5UPkErnAmfuvVInt+
 0Or/SuCF8uOhbugGliPXLe/Oyy23UtZnFQij0+G/LWzk8jBL3jp/2dYXShw49pQ1e/ieZkVxQvy
 eTkUaTTQYdbIwCl1eb6aWGwODq2iYrlBbXsw+CI5w3Nrbe9rNV8gJE7nULdaAH7trjvivty7Xn2
 ewVMQ/17mDGNIWJ7Mgi4++1+nWXlgRc9Df1Sw0oiHYuTRu3wfklY+25QtGHVxJhu4unS9gODnB4
 mFtNdWbIXLoPc5Xnuw7qar6OH9kj3EtrKlQ7bWloWfSnT5Uktd/ox5sRrYQnhxNpKPb17nro=
X-Received: by 2002:a17:90b:3c0b:b0:398:b1eb:136c with SMTP id
 98e67ed59e1d1-39d9bd5e49emr13876754a91.9.1789209885009; 
 Sat, 12 Sep 2026 03:44:45 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0b:b0:398:b1eb:136c with SMTP id
 98e67ed59e1d1-39d9bd5e49emr13876714a91.9.1789209884570; 
 Sat, 12 Sep 2026 03:44:44 -0700 (PDT)
Received: from [10.133.33.219] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39db113a3d0sm5351157a91.14.2026.09.12.03.44.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 03:44:44 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------NPpJn54gfU0GXWMMVsumK9hy"
Message-ID: <00715b36-7621-4a17-9998-9003473bff77@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 18:44:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
References: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
 <b10cb8de-638f-48bc-9880-edecf35e4659@oss.qualcomm.com>
Content-Language: en-US
Cc: arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
 sumit.semwal@linaro.org, christian.koenig@amd.com, quic_lxu5@quicinc.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, quic_chennak@quicinc.com
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <b10cb8de-638f-48bc-9880-edecf35e4659@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=e+mT2qp/ c=1 sm=1 tr=0 ts=6aa52d1e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=jKsoHjBsZuWLGqAzdFcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=EUspDBNiAAAA:8
 a=VJ8hSp9LWsRA7Wmw0-0A:9 a=Pcn56v9LyNFJUGKV:21 a=_W_S_7VecoQA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE1NCBTYWx0ZWRfX2f/w2LqV5Q5a
 K++bAsE1yzozeI+38tVhEHGJNZwSWfIMt31r1fcCTe4jTsA48d04GliGbPvDW2O1sL8CqRSW5Fr
 MdODUHrTKhrqwo7dZqlyo2KSpU+ixi4=
X-Proofpoint-ORIG-GUID: Zw0gD9pydP7YZCYdHN_YdvlP6tangQ28
X-Proofpoint-GUID: Zw0gD9pydP7YZCYdHN_YdvlP6tangQ28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE1NCBTYWx0ZWRfX6aK0UYl69BNH
 iKiQqKkZOPms69YhOQcs8O8PrpyndS/J+LU9XWqUviJOKIrAq+A/zBlOAKNFNXb0QryvJn0tSdJ
 RGt3rN8gw3NO/sWuMBs32IMjioK5pzxAD65+t48x/U4w4AlVZj//HUUjMFGrYXnmltdBW0zcj4K
 GxkOPp0lzneuSBOyq3eTQGOdVvMEhYrIes2WzCBGAkTYCYamOo18v22j3ZIdxGPmYaP+qd+AEmp
 ApwHjbyXnd/rLukpxQPaEdOyYkNqZkirUt6mHf4/1jra7mShZCb7rs1szAFQZjG0uE3+31cRq/2
 IFKCs86rQFKB7W+XSwLuL08jBkOJXY+RZ/S8YPMrNzW0C16Tgz0oMiWXZG4XrkilemG7aaE8wDG
 u0oD3AHz/j1SsH0dwY+l3YRgRQ2HXtjx0C82NKBQKQNhjILrCVPM3uEm6oBC+SWMw2WUGP9ATj8
 juPOg+IhyE4BO9aFS0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120154
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
--------------NPpJn54gfU0GXWMMVsumK9hy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/2026 7:41 PM, Ekansh Gupta wrote:
>> +	/* Map the DMA handle in the invoke call for backward compatibility */
>> +	FASTRPC_MAP_DMA_HANDLE = 0x20000,
> was having a looks again at this, user is never passing this flag,
> should we have this in uapi? I think you can move this in kernel as it
> is set and used by kernel.>  	FASTRPC_MAP_MAX,

Agreed, thanks for catching this. FASTRPC_MAP_DMA_HANDLE is only ever
set and consumed internally by the driver to tag DMA handle maps — userspace
never passes it as an input flag — so it doesn't belong in the uapi. I'll move
it to a kernel-internal definition (not exposed via uapi) in the next version,
and drop it from the header.

>>   };
--------------NPpJn54gfU0GXWMMVsumK9hy
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
    <div class="moz-cite-prefix">On 9/11/2026 7:41 PM, Ekansh Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b10cb8de-638f-48bc-9880-edecf35e4659@oss.qualcomm.com">
      <pre class="moz-quote-pre" wrap=""><blockquote type="cite"
      style="color: #007cff;"><pre wrap="" class="moz-quote-pre">+	/* Map the DMA handle in the invoke call for backward compatibility */
+	FASTRPC_MAP_DMA_HANDLE = 0x20000,
</pre></blockquote><pre wrap="" class="moz-quote-pre">was having a looks again at this, user is never passing this flag,
should we have this in uapi? I think you can move this in kernel as it
is set and used by kernel.&gt;  	FASTRPC_MAP_MAX,</pre></pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre" style="white-space: pre-wrap;">Agreed, thanks for catching this. FASTRPC_MAP_DMA_HANDLE is only ever
set and consumed internally by the driver to tag DMA handle maps — userspace
never passes it as an input flag — so it doesn't belong in the uapi. I'll move
it to a kernel-internal definition (not exposed via uapi) in the next version,
and drop it from the header.</pre>
    <blockquote type="cite"
      cite="mid:b10cb8de-638f-48bc-9880-edecf35e4659@oss.qualcomm.com">
      <pre class="moz-quote-pre" wrap=""><pre wrap=""
      class="moz-quote-pre">
</pre><blockquote type="cite" style="color: #007cff;"><pre wrap=""
      class="moz-quote-pre"> };</pre></blockquote></pre>
    </blockquote>
  </body>
</html>

--------------NPpJn54gfU0GXWMMVsumK9hy--
