Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BB606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q+uOJQx6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IK4XG5kD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D91F10E184;
	Fri, 30 Oct 2026 17:47:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C6A10E184
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:47:28 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERuYQ1953891
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RKBYhPhEC+UwaTqew5bmTNWlU+HnyY6Comv/tpdax1E=; b=Q+uOJQx6MN7bb3Qp
 RIQYTGJp2FfIusVoQOW4c63d9kjqf9fxZE5a+4AMLZ03E3UWZKhYtxxNDQxmrv4d
 D7nXu9WxEBKPvZXkAgtmE08o/m638bt1LeKz9gZqzO9Z1F4WrmKB4hhO4d/kw2/Y
 AByqDlV1dclPMk97s/tXSR8QqMgqvUPrMSzmAy/GlYXH9UH+KBCu8JujNQHC6D9i
 evxujPQd6NPk0uS5cLyla83tXlWHbJi4/pywcNTdQg7JBet1vESc646SDTrxon0c
 UGQQYWMKkY8K/GpKNr3A8akHe+CgD7KJtltINTYsYqKDqBvtnA5bqsHO9TjFGM9A
 3+Zc0w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmaaf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:47:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1792499eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382447; x=1793987247;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RKBYhPhEC+UwaTqew5bmTNWlU+HnyY6Comv/tpdax1E=;
 b=IK4XG5kD+Hvn78LlWTWPLd4nq8bNvg2dPxwgzaYJBjpnVnBuWCaMenoF8yOIeMcFkz
 FJ6LsAcFWmpWX+3rAh1tBr2eko4cZhVFE12itIQ7/nlzc74HNVUAGymOlULzV/xGEWLi
 kw1X7/I5FtrTrPg/onMwb+3WpKfMp2LPlzh1XQCdH7roqe7cBhSKyzUUQt3vUEfHThFq
 D4bqCLozjHb9YvlSIRv92BM2fpyur0ew6CLm+Y3VfQoOzcGYpguQrL7kGizaRkQ1QJBW
 3LXtZyjDKo66aZQXtlY2cwsmpVWQTyZhdk+97amF6EcSAPDEWa/SrlFmSWxJRCNVanrA
 zbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382447; x=1793987247;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RKBYhPhEC+UwaTqew5bmTNWlU+HnyY6Comv/tpdax1E=;
 b=HijjwpAFbIJrnZcgmvmjTqyXll4bR7NBuEEPrFWCx9p6d+k9GSxtY6PY11i3KQE5vs
 PdW8XsqBefFbG+J2cCtBYeMrRQmYm9vLU2jLNccqnKWB0qWRmPKcq5JSL+b/OOaIgzrN
 kF4s9u9kcrm4xjoPoYuzq2A9NM9LD2PAwOQAMEsXqYG6tFiezevHbbIvlnk2Wj6Dgjri
 uBky/qYvuMHusRCmj73oCb9oyIeS0ZpYsXxHgm5nndWATgNvLycJ9Tt4lU4uD9EVshk5
 8N4c8PDUv0pe347FFTyoifbXxW73DSDrpS8rPTfnwsSSLo7Wxh4KpiWtCjUt4CiDgmqd
 dctA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmo0MnA1V2XGVgkVLOahhMieUsM5n3URfrDgGUZllHA8tElUpyOYwtLwGSRk4R75g2YKYYqmUG0fI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJMd6sEloDNxD2zV7HgyD17SWSUVq33SGPwKX/tLd+L7bCiln9w
 Bf1e8LkOy1DemodoVYPmaEYNY9ORQWMPPIkjpiqmIXGJD8f4lmzLL8UvsDHFJgd1kIEC3ZL1QeJ
 YWYIUe/r/45ZBoYcBRb9xfu71Zq8ATTF2f+mxIEiNCpFjMknTKgyL+lt4+mtYIQFWmA/AjBc=
X-Gm-Gg: AYBFou2YXzrJcoUUqaHGBEaWZ8GLknB/sxsIqbkWoHolzvMA2gni60lrgSU54l278yZ
 Of6mCb7ykKdxcmCYVM67jNu9EZMS9bqFAHvn8dgAlAE3SNBz6qCo9TYnII5F/dBnHGzkmOiZoOa
 NKnlwc210b/FgJL+kF7RfNT3jWTXx6xwERq16d2YEaW2h9lcM20gfB0tuSjqArdnw47DraJssHf
 AYmg87vShJOZl2VFYGklSaSOAiFNYm0v6UbivjqlicCg/MlvQJPdDPeC+h3ZdNKUSF3Sb0vfamx
 MVtEeBcygZIqqmrHmfTsCrDhGBs+PfsewoAHsPeKbjBCso4iCCTjXLrdK9plCNrCfI2Ih613uX+
 51jPzh8vWQFiyPA94qaJJ8RBqn7mCfvGfbka5jUSzLQ3FuhKThpnP1n31XjZviFcsvpAkkstdMI
 mmrV+jd1cFikwh7XnxcalgTW8=
X-Received: by 2002:a05:7300:aca8:b0:35d:28aa:3ae6 with SMTP id
 5a478bee46e88-36a4244e81amr5894607eec.32.1793382446877; 
 Fri, 30 Oct 2026 10:47:26 -0700 (PDT)
X-Received: by 2002:a05:7300:aca8:b0:35d:28aa:3ae6 with SMTP id
 5a478bee46e88-36a4244e81amr5894546eec.32.1793382446272; 
 Fri, 30 Oct 2026 10:47:26 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm8787868eec.19.2026.10.30.10.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 10:47:25 -0700 (PDT)
Message-ID: <683ca22c-f0f8-458f-8323-214945ae6d45@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:47:24 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] Add documentation for Sahara protocol
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-1-dc9f24357c4a@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-1-dc9f24357c4a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX7zvZfIgkX5LM
 1pao58XVKvigRRnTBdWv0bqnzLlj041DavfguVDUT4AWmi15dm68uR7Zo4Gb8MdWKaqzHoOYr95
 5dq/b0N89jOA9200unmPqYrAKbZpvxzDYnfbHVHtu62IvimwS0QN3Ou39L2cQOUZODAQI7N4X8w
 3XVLIO9qhFJO4rmvvtahqp/xgIxDztuL5hFu+RtnXMWJXNFVC+278J2KeGGaapHBq3xuF616Uqg
 0rFLSEhHpWq7rjnbh/XGlOwO4HgklGKwPCasGIS6tBx67E7s0l+hfE5TarQgCUueePS2KiQUQSW
 AY2sy7SAPtGP7w0QiysZ9kCWRmqM5aeEvipSUW2BolBwcC7qVVsgGydmAO3FVSvMkniXkbY9lNI
 eEdmi0wVytx7FugQo61T/6f7LewzbcFrcQbVElhKYgF6R4I/3Sjx9PPa0FsOTf3mPAhI9DCQdPs
 vA2DIm3uJwXzileC79Q==
X-Proofpoint-ORIG-GUID: SPyGyDZg0DZkj4PmrcZPw7pejLhmSSSi
X-Proofpoint-GUID: SPyGyDZg0DZkj4PmrcZPw7pejLhmSSSi
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4d82f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=dq9AVsfMO__Ke9BKiAIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX9KA7HBinSLWj
 E2kfDf2q5ogp5M6fKV/wQlmQTog958kSqIkuH6l4ao7qReaCH4jaNPJ5qQYZsUXtjJb0OhB89S0
 w40Y0dG6JRSFpQePJLvN/OweER3yeLA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300070
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/2026 2:45 AM, Kishore Batta wrote:
> Introduce documentation for the Sahara protocol, describing its
> operational modes and their respective functions. The image transfer mode
> enables firmware transfer from host to device. The memory debug mode
> allows extraction of device memory contents to host. The command mode
> facilitates retrieval of DDR training data from the device and also
> to restore the training data back to device in subsequent boot of device
> to save boot time.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>   Documentation/mhi/index.rst           |    1 +
>   Documentation/mhi/sahara_protocol.rst | 1241 +++++++++++++++++++++++++++++++++
>   2 files changed, 1242 insertions(+)
> 
> diff --git a/Documentation/mhi/index.rst b/Documentation/mhi/index.rst
> index 0aa00482aa2e2d7ec4941154a8c6947dc0a0ac40..39a38978398b81727514ec95dee4e060a1063b34 100644
> --- a/Documentation/mhi/index.rst
> +++ b/Documentation/mhi/index.rst
> @@ -9,3 +9,4 @@ MHI
>   
>      mhi
>      topology
> +   sahara_protocol
> diff --git a/Documentation/mhi/sahara_protocol.rst b/Documentation/mhi/sahara_protocol.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..3190e3e5a2820628e89efcf759c9ca634428f8b2
> --- /dev/null
> +++ b/Documentation/mhi/sahara_protocol.rst
> @@ -0,0 +1,1241 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +
> +=============================
> +Sahara protocol Specification

I think either "Sahara Protocol Specification" or "Sahara protocol 
specification". Having lowercase protocol sandwiched between uppercase 
words seems weird.


> +Hello Packet

Until here, "packet" was lowercase. Please be consistent.

Also, somewhere around the read data packet section, it seems like you 
stopped capitalizing the packet type as well.

Also, did you run the make doc make target and look over this?  Also 
around the read data packet section you start using the section 
delimiter "=" instead of subsection delimiter "-".

The inconsistencies in the formatting of this documentation are probably 
going to make it very hard to read.
