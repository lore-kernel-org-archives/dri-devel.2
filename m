Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093C606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DF9l6fBh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PM7WiT61
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1EB10E867;
	Tue, 24 Nov 2026 12:56:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1640E10F57F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:56:38 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAua9g3299644
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9oES+zTBCcykoKXXZVrUciLOTnpuEmEfvSoDUlTPuAk=; b=DF9l6fBhukovloIC
 lPAH3FWFLecA/J39y/gmIcTRUZ4Lq6KdDnf7flVguXLxS98olplmggiZUXMdOIB1
 +JlpZBE+CaOqvVWntozlbjrGn6AftMMOpc8LyhzNuhibzbGLIz0/Zt9nW3v8RW5q
 w/F/ZoQAYlFQNrSu/yZ8aeWv5iZjgv2EJPhYqJCjy00T79DfpxAfSxSM/SNeXj4M
 rQcE5pKEZCYXh9LTd81L8LsMXbMw0XKfa5vyEiCfqs64YvY18Y82JnqGBgB2n4Iv
 GiiS60bcEkckNkgC3aYBeqNE2JmW8vKrZuL4Bv2vZ3Wrm5hTNG1EJJRis2JmeqdY
 NcTLZA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yy12tc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:56:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8b203b0c139so3276171b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795524996; x=1796129796;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9oES+zTBCcykoKXXZVrUciLOTnpuEmEfvSoDUlTPuAk=;
 b=PM7WiT61ArDvilXMU0RspblocRLE99umSFcHRzvUX7ymfSSJ4kYL0M4YEW9AzwdIHt
 gbn29JEpLO52HDygjmVzjJYPO1bknDUWCiU4D6T6VplV7EzXXNtGEKLJ6o+eFkBHqiwz
 TFRShksOKokk9Ul9wNI2yLsuI/cCAfngttVVz+CEiB5IeuAhqsUyvleyZxDVuTtySvTD
 o76jV8qOGInpqMI69u3nZs508x3MbGbLrYCXRR+zp6tMT1t72Mieon+2l4fSZPTAYcrB
 ecI1j0/D4vDtj+VK6ibQaYHq+g1BSUxhbgALymSXtjhF9A9E+7Rwk8NlGrhLgZfmZmYk
 fe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795524996; x=1796129796;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9oES+zTBCcykoKXXZVrUciLOTnpuEmEfvSoDUlTPuAk=;
 b=i4aCYZ+PFz1zNr2tyjmEqmTxEesCMNb3WCbiAYsKk5akHf9/0FT66RPVXkEgT6hQTV
 mDOz6xkRQztXRZidyVbncjq/FcUyKgIELEUWe3PStVItd0pHg43DH3qzjECflkt+qb5Z
 fmMUnWxDsDyXDEVDJwm6CTRcGw6yodGD9MhbueFId2nxbVkUprQSYSn2OUymLXw42bxZ
 DnAp+z/hQanKdb6hrSiYuinoE+c4rk5IbO+YPCsW+TEAqZ6bg1GcxeCfgv9WM7omrWPG
 pzzBICO9lDlk7siWJBQHCKXJrhLGtc0gFJL9J++5bPAz/5Ft64/cKviJly08wVyAfUJv
 pv1A==
X-Gm-Message-State: APuU4Z8D4v/cGRoLJE6Bp0REjxUEDFgndTUOC6eyrtR4VAX1acB5GfMa
 SxGOq4Jg4smft1dhcOnvGgioY0wx2ayjHDgE1IeAN0v2ObxH3GTYgtdzHFSvCUUN3k7gcS0wMXd
 cpEvJN9CXWxJPElYGuXjmYuTx3ZxohRbCdJdsNHwloFxt6SfATnU9K+bA99FXUTiA/4qVAeA=
X-Gm-Gg: AZFdTZdIuS700ddMmRCqrfuXJhOJl4sAF06jd0xFkIyQ7XL9FMxl6AOhFt7noJn4HHt
 iyae8nDGJ7rIvHMwPjMnqIdRErNqZB4/s6d4JkcLhjg4Na9wJ7jR0CofeWmyfZ2zRqxvqEBr7k8
 BYvWryBFOUUea8gBlr32W5cD96sK4LrOj8JNgI1ldx3UGPpUl6JuwOYp0vmdfugMTC4t2aNcwoV
 y7O5b7IpmQpR2M8ZiR63qb73qRjsA2VsWt5D7rfNF5uW7/GsP1eypOdFzYCn8GwgWC120yUav1m
 i7qeVu9HnHcMd7r8JanRdtBhUeqCac4J3kn0ir04QPyW+q19UsNx8HU3RvhAhoT9uKdQJrecAZx
 LveHP0uU3szZCrIKhfkknADxjLjuO09g1tBxEYM4afRJ8sRF9jFLbk+YbredNw35kcoIuqIia7g
 ANrw==
X-Received: by 2002:a05:6a00:4c19:b0:8b5:f313:9f54 with SMTP id
 d2e1a72fcca58-8c87d32b35cmr12156940b3a.56.1795524996079; 
 Tue, 24 Nov 2026 04:56:36 -0800 (PST)
X-Received: by 2002:a05:6a00:4c19:b0:8b5:f313:9f54 with SMTP id
 d2e1a72fcca58-8c87d32b35cmr12156914b3a.56.1795524995577; 
 Tue, 24 Nov 2026 04:56:35 -0800 (PST)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87285c263sm7146216b3a.11.2026.11.24.04.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 04:56:34 -0800 (PST)
Message-ID: <0747efbf-c712-4185-b08a-82c82a49b4a2@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 18:26:27 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add Parade PS195 bridge support to enable HDMI on
 Glymur/Mahua/Kalambo CRDs
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
 <357f0fcb-792b-4b40-84d2-cdfd05ca05eb@kernel.org>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <357f0fcb-792b-4b40-84d2-cdfd05ca05eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MXW5w_Ck_QiEmEEyiUGHOlbcpiT2e7cz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MCBTYWx0ZWRfX7mvnytwj/ubz
 0FMKK8tRJkF9yJ/qK3lftiap8Z08BvKCsZELo52qonboBwfRMg8Dn/dsEjdQ/+HYUMQdr+7LBD9
 MoG6V1MPqflJpenz6qNcr+Y38ZYx6P0=
X-Authority-Analysis: v=2.4 cv=JYspPkKV c=1 sm=1 tr=0 ts=6b058985 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p1ES9sUSU55KWy82zVEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MCBTYWx0ZWRfX90HbInviOzH0
 2WSlQ+gtMhz9DeoRnEk5O+P1kZrFu5k18CKgHXuFaZ5aFFWc9g7roosfpLUHHZaFzZGU3qgY2OZ
 Jzd+YuUNFlmwQQYZq25Rjmpi9T5CZddx598hfxvAPxg7YuoD7ERAf4eTfjaAm+vbWqq5+HTLxO0
 TGiZG89klVIbIs9VPBkEcM/FOG9esleEaP+VD2l+GqZ8uegzcFi7KF+6z2W+fZXOiKObEuyhrWu
 F0RyzQ8G+HMe3M8TBZbaYE+2y95XC5ieALgVoTPkGklSsq4ybbzR8I2LlUNL5evVGD/98KiK7kM
 iz4pJBCTiCMLtzT7Dcn0g/MNEqmEb9XOwtYb63mCNwzqGb9LhJOEmqbagXsFlBNP54wmSZ7Nt6R
 mTHjVx3lidPeGEMLF7LgShl7Il0e/jq7rq7gXg8gbPRCsb1zyB9izpDMJk3IjIBxM6Ddr0QKq6O
 g3iFf1leSNEPvEk3ySA==
X-Proofpoint-GUID: MXW5w_Ck_QiEmEEyiUGHOlbcpiT2e7cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240050
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


On 11/17/2026 3:54 PM, Krzysztof Kozlowski wrote:
> On 16/11/2026 12:34, Nabige Aala wrote:
>> This series adds initial Linux support for the Parade PS195 DP-to-HDMI
>> bridge and uses it to enable HDMI on the Qualcomm Glymur CRD family
>> (Glymur CoB/SiP, Mahua, and Kalambo).
>>
>> The PS195 operates autonomously using firmware loaded from external
>> SPI flash — it handles link training, EDID access, and hotplug detection
>> without host register intervention at runtime, so no existing bridge
>> driver fits its power-sequencing and reset model.
>>
>> It introduces:
>>
>> - a DT binding for PS195 (supplies, optional reset GPIO, and port graph),
>> - a DRM bridge driver that implements PS195 power sequencing and PM handling, and
>> - arm64 integration (defconfig + shared glymur-crd.dtsi wiring) so all three
>>    variants can route DP over USB2 QMP combo PHY to HDMI through PS195.
>>
>> Deps:
>> PHY PLL change: https://lore.kernel.org/all/20261028-glymur-phy-v3-v6-0-1f1d2e565a66@oss.qualcomm.com/
>> Glymur commonize change for regulator: https://lore.kernel.org/all/20261106-topic-sip_cob-v3-0-52cd3826ab49@oss.qualcomm.com/
> So this cannot be merged. DTS cannot depend on drivers patchset. We
> talked about this multiple times already, please do not couple
> unnecessary dependencies.
Ack, I'll remove the PHY driver dependency in the next revision.

Thanks,
Nabige
> Best regards,
> Krzysztof
