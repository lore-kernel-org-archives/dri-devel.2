Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DFD606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yptddehu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DTWBmiub
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B8610F96F;
	Wed, 11 Nov 2026 08:36:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0EFA10F96F
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:35:55 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KIDh1369025
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fQqe2AyHT0YtNm9ybUXW8UaggXCo/B0M8+3MYB5QA40=; b=Yptddehu+01hnYqt
 +7LCcjvPhkQb4W7x2CNWLKvcWykCpCP8/a7RKhS7aaCTE6xUA/WON5THudMuuZHg
 rtZ4uJvXK/d37KEcK83bvyPbwSgUIUUFwyZUxRT8m15LhUrEUsOMuRCdl0CSPPML
 VWxej5404/r2tbH8hLw0Oj08yFSU/RcZ5T5HmRjmWQzW908IocRrCj2qP9/F7IkK
 CZRWN7czKmL1lH5S6d8f6F+mY3rXzjX5ITO0onSFKt/1Cpoaw2dnIOgruRw6V0tN
 fa6QNBgDj8WVfXX5PLgcBiGATsdm6ZOHxRFq+UFR/fAR0LYgJsOlMgrrHoNX7Ein
 +5tMkQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvcpehu3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:35:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5033532eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794386153; x=1794990953;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fQqe2AyHT0YtNm9ybUXW8UaggXCo/B0M8+3MYB5QA40=;
 b=DTWBmiubVbfCceCv0BMqiCxVPC4+0QjsJCewFCdsIvB6KYxKtBVEVoJGfKYlYKIpxs
 BYreSqM/PHHGQkETrj0EAOkxSWcKi1F9awt+a4Ew+gUEsSAP1/qibZ5MAGKc2Zi1AEXJ
 W5O7/VS2o7qNEQwAAF5T+sC2PAs3touQ2yxyPeIU6hHsM/GNbnN96F2SiBSUbZQ/FU1X
 nw+0UpPICUFgfguD0zbLKfTCFeFtJqMUF5tgqs0LTnxmw+xQjAZDyodIQUpgCtwVlImc
 7W3Y2B6QV9E+WSXvC6Mc1X84R37wZnakXRCfCEQl44B60w1U68FqP80fIyK2DnndPhw/
 LZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386153; x=1794990953;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQqe2AyHT0YtNm9ybUXW8UaggXCo/B0M8+3MYB5QA40=;
 b=zwV07AImWjpuN6g2gGnB0je9Nl1Cz1cAsLoBT9jlLoCrVpf7vW0D4OqkEBLnkUqtJ3
 E1jLYZbn1KEhQNdZvDfb4XzdxLJG1jkIWS/Bn8ZxZrPlMSOUnmd/2LgYR01FAF0CwJ5R
 Er8sbYBh9TP+AOxyYn+luAZlnvCXaVLzJoOEWte3z+4ehGuUYRV8Tw+lQ31jbLuFPYrB
 ZdLavbaa+TeVm2g3dbpud2uDMhrl4Ppv3K4HIsvG+JfFDoltzxD5LvlcCKThuaFTCR6Q
 ViP5A5tauIPzuXBUeCZ09sBJn6aH/fgLvDuWL99Ff1Zey519eYgcHMvHPz7Ko2r6CxTp
 RMcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGbDMeRlL7AoMi64kABrErnrykWA7yL7bOxQsxDyMKAdAiE+d7nvEIJKH4QQ0vWw8md0fcfn/+Kpas=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/LKkkyw1J5CqsV24Cv3DBAWDeZoVANcuZkyTeMHv08uYDJ5srx
 QoI5vYuk+Shh8W8I/Jp/W0htikuerclG19x2Q52s8oYJZ/mIOpjsW/nvM+6qAxwEPBOPz7O+6Hz
 3QprUjoBoqRQ+PNg6zL9QhESrj0I3j9+MVcNU908jabNyfDk/kp7TqkJIQxBzTWwEM4qsd/4=
X-Gm-Gg: AYBFou1l3Z3HGwT+FvFQUvW7pB8PP7/J0kvr532lYmS+7sVVPwFxUVYDN8C36fNExR3
 NdB6jERcs5h8M7RRJrXktgOi07JnFILaQVK3npi+/cNhyWq2tL1OiZSVp9JjORDKKZNVwL/yEkX
 JcimcccXI6Slkuil8O89NmAQ8Tw7gjRsZPaOtrix61ts4HsvQy0IMFp0YCvl7/tX88NvMQ7wr1m
 qhbXqelcH9suizhtLc3GGbR2A4CzzQSKoKeKAfSqyPfByMT8tuPRQo8TCOa/PrdDjQj2TKuJ0JK
 IdBgxjK8PAq7CeCOj1q05XWoUBO5FatTkIXYxWU6Hpp7moZ0180NzHUWYmMRxZCpm8waI17zZ5v
 Jvyg3LTjL+wNNhSgO6lNjxN0aKVMHlNQZem4MRtI3+EvV0RebXY3/J9EVmjbuXLkcT7VTWQUdiF
 Eqo00=
X-Received: by 2002:a05:7300:7f27:b0:369:9af5:7bc9 with SMTP id
 5a478bee46e88-37685c7a324mr2436974eec.23.1794386152993; 
 Wed, 11 Nov 2026 00:35:52 -0800 (PST)
X-Received: by 2002:a05:7300:7f27:b0:369:9af5:7bc9 with SMTP id
 5a478bee46e88-37685c7a324mr2436935eec.23.1794386152463; 
 Wed, 11 Nov 2026 00:35:52 -0800 (PST)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bfb58dsm25690687eec.18.2026.11.11.00.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 00:35:51 -0800 (PST)
Message-ID: <baf7c1fc-5eb6-4b39-a396-3df0d367e3fc@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:05:41 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/25] accel/qda: Assign a context bank to each session
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
 <20261102-v4-v4-4-88f2f24a5f0b@qti.qualcomm.com>
 <e155f52a-cb04-4334-bc7c-54385973c87d@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <e155f52a-cb04-4334-bc7c-54385973c87d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX612v4nhxVyIL
 Rw82jWcPp1/wiVt3p/WjkiZ38B+fTyr0mt01igZUK6J4NoXb8yT8wdtZVcCpIFbvj8vXeaFoiz7
 Vu8+EH8yNBGSNz2iSrPr/yWITuoOe5wxPcG0HArht6i1p5yb3MwUOyDNAqNEkiSbMxW6gJ4sH/0
 1UN+oNjzOA7cL78od9T9IVfP9K7MT416AvkTJVVlcUesP03+jVdCdzLO47TzShCdJ3RmaCwRcDx
 JrNjyoH9vK68VP6hZiu3vamvqwJCP5pmHa7jFkut7ULQf5mH4iLjQbdaNsE30u92sneCkIwNnCA
 jeynztyyPZGITvZws3pdKN+NfZp6aAuKliLGZojasN87xnHOvePybPGD9d3hu4vUU2L0z3+BwF4
 L8vDRUy9SU3hDUazMq8P1m0KgwY4nt6CK2SxutmNW38nS+IogBPQnKbcJMPAL09OpkEpsmnXky3
 l8JmpU+7bgmQfvduj0g==
X-Proofpoint-ORIG-GUID: EhSzYfIkenrUS33029f4Skwuim9_FMg7
X-Proofpoint-GUID: EhSzYfIkenrUS33029f4Skwuim9_FMg7
X-Authority-Analysis: v=2.4 cv=RfAFmFtv c=1 sm=1 tr=0 ts=6af428ea cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=AF3zZIX-EdkCpG9-7AIA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfXwYLfx0+q0jFh
 mEf+k+5lPkpUaqHjiNgj4CpZLBx6W4r9+iLP7PhYEMyZ1YNEPk+cbHkNptDC6/fgDjSCqiS2SFC
 noSJjBzmFxcEEgbhc8ekG8bWZtmmCSA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110034
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

On 02-11-2026 14:15, Krzysztof Kozlowski wrote:
> On 01/11/2026 23:21, Ekansh Gupta wrote:
>> +
>> +static int qda_count_cb_nodes(struct device_node *parent_node)
>> +{
>> +	int count = 0;
>> +
>> +	for_each_available_child_of_node_scoped(parent_node, child)
> 
> I don't see a need for scoped loop.
will switch to for_each_available_child_of_node()

> 
>> +		if (of_device_is_compatible(child, "qcom,fastrpc-compute-cb"))
>> +			count++;
>> +
>> +	return count;
>>  }
> 
> 
> 
> Best regards,
> Krzysztof

