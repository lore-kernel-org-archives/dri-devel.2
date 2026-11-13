Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAB606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1uMajdG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NBkr8DqI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8572410E0AA;
	Fri, 13 Nov 2026 04:52:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A82410E0AA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 04:52:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD2Kv3X538112
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 04:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UMrXrqjcsDJ3ihciM+V6CPHNii9aPk5xl4qMC0+9WnY=; b=m1uMajdGfB8yNmqF
 Bv6eb/e7HDfPOxU/G29prAYNpGd6MNvArlxR+mYcCDGDpIFi7s0oJPb1y437KXj+
 twmqPirPxPyhnYKvCzV+yuAab4993STXKfVw6grkwIjPPDYR0U5Q6w8B6NWdiFU6
 8mNbH/JWVuFeDnngEkNj1eSjJkE/Kdo6db4kUuADp8WL7VECjHhEON/OwiTz7z86
 WCd1XFUNkvv0vYrWo8aL9TBvMCj1cbJhXrThDa5sQQo8hXTFXbiAYQGiV9kgz2kK
 TXeosIb/4zNRoBLNdR05/ByEqWorjLDydZoAawNlCOU4AR7pfMCijbQ7mcQMEt7P
 Vy/Rnw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwc1j3cj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 04:52:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so956614a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 20:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794545525; x=1795150325;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UMrXrqjcsDJ3ihciM+V6CPHNii9aPk5xl4qMC0+9WnY=;
 b=NBkr8DqIujkspAZLTuEacT3pZz8SGGbp98HH6ghKt+MebU5eA3qofTULPy4sK7foQ+
 UDoHOGHLsRZbpM8h+5jF7OjtVXR0t/o4TjFCBGr6xE18pvPGP0oS8BAAXEKXoLuR3I/3
 z/9Jdkv7EDKTzRY2cMmiW7BDUi96egLDdk+jwwjUbxTNUze0ATEgsfPjA5RbteXg14A0
 we5xvlh6wTFmAclOpQzvEKdXuyGXXZQdjUF60tiR6gG9DnYUfk7EKxyN0F5Frezt44sH
 sipwhAFja8cmIE+TnrVrSqzRO7TLcsnk/q3tJnVfhip+I7n7284HG84EeIUHLc/Fc7BB
 fR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794545525; x=1795150325;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMrXrqjcsDJ3ihciM+V6CPHNii9aPk5xl4qMC0+9WnY=;
 b=v1Bf5smwJEOrwT4fyj4qNH+uSYi5WX6QPLHOLw9VI3jcdldHKn7VVoruxVNLpCKgC3
 B4a79zGjsWexfwZ1m9QBkKhGKgBLxdwQQ52p4r1ZlNZmlVznBW2Vejk+8a5EqQZqQox2
 9Z8Bqhx6WCGsC4srbfS2Us1Hy8x0QBvMZWHcC+EP6zY5Db1Rr5JxzZ7L5P450WZBu/b4
 ML6yzcxClKvaYzCNyvEIgAMs17MEf+ATjmzD7HCABC5hpZ5d+EsLOUSx1UKhmWLSXIJW
 FhbsdNitOeMy4wgBasaYHwrllKy4JiPUvrI+fP12TNrj9IqQCxta6G9fzSjjYqk9+3Oz
 fX8g==
X-Forwarded-Encrypted: i=1;
 AL+hErHipXRavpYjkz0XUYofqJ+G2k0/YIbea3MWYxwZKHtjn3lDn4b252JqKU6aW76n3istpjC2xkRQV0Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z806yNLI5tWF6Y6qyrDnql9PG7TH4KTjw22zJj2bguhAdkTjPVd
 bQNC7FxSnzKlZBNePbtpaWZrao3OiIy7y9uI4Mmmgw3GyJxsq4rYHU/t1zEZHfq9kc6Eg9H3wUK
 xKipHPXKFXfi2q1ajupGLesh48yTAbd5oOj/csWpYCBpXjkmpvKStesJrdBfew+Xzl/ohbTo=
X-Gm-Gg: AYBFou0OEOYC18oLQsE3zOf0QNsT5bXoXdOlf/BTUme9EKq4Lfh69GSjBufaarBpLvp
 SmroQrtlnBVPWb2/KsM0up8hXPtzCwqOYxXv5A9+wGkib1xW0jnmYrhaNL1158KwTM+sAH6pPB3
 MUWWGAIjJj3ElngDf1UdKbT/t39A5USp5TMRXyB2oPlnY8KhiAhMQFRYtLJvjWOh0M+klodEkZj
 f2pucHJyoS4bB7CIm29Uv3ZWqhUmlLfl9YknanBzApl5W2FwxN/gXzXM1ifKAntxBsdDWSlJ2sG
 554eA2qm5L9MA9Flzlcf/C3Tudc7lj4FPD3jV1lC2yhGeN6aTr7coE7UI/seYYDxNqK6ZfxJ/z7
 uy8E8txK7C+LJk1N8hU4QSFTb7W7JxoerhBX2zNz+5dYABWHFLWM1ygQ8TELnBw==
X-Received: by 2002:a17:90b:574b:b0:3ac:b145:8f4 with SMTP id
 98e67ed59e1d1-3b1b0cc9790mr1123857a91.41.1794545525003; 
 Thu, 12 Nov 2026 20:52:05 -0800 (PST)
X-Received: by 2002:a17:90b:574b:b0:3ac:b145:8f4 with SMTP id
 98e67ed59e1d1-3b1b0cc9790mr1123826a91.41.1794545524150; 
 Thu, 12 Nov 2026 20:52:04 -0800 (PST)
Received: from [10.204.79.100] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aec63b9bsm2524494a91.12.2026.11.12.20.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 20:52:03 -0800 (PST)
Message-ID: <8d30551c-38b0-4f4d-a532-f574ebb5373a@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:21:56 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] phy: qcom: qmp-combo: delay Type-C mux switch
 while DP PHY is initializing
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, irlied@gmail.com, simona@ffwll.ch,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
 quic_mkuntuma@quicinc.com, mahadevan.p@oss.qualcomm.com
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-2-naidu.nama@oss.qualcomm.com>
 <xby27hg6ajesijmdclu7f2sa2swv4ednmokka2pbn7uaufm3za@czdij7j2qcml>
Content-Language: en-US
From: Naidu Nama <naidu.nama@oss.qualcomm.com>
In-Reply-To: <xby27hg6ajesijmdclu7f2sa2swv4ednmokka2pbn7uaufm3za@czdij7j2qcml>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfXyHn6eU47knn9
 CPUHceXxEENyrk5cxvhfp64WPv8NlJi9GLAxuiGRoxj4G0br1fX45nPiJs7vj6g8Eag/rqD95E4
 tPaBHj2mPHCwoLAchSXzikfgemqNBBM=
X-Proofpoint-ORIG-GUID: bBZfsiV64WdsU_BYm0VZudciz0-OSylc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfXyPQLAXOUgnZR
 /GatFgm+TUOPOHNUfFGnqzI5d45RXV1dnPi/wOAcfw/800w41Prit27/osMo4AEFrXV7IcdId1h
 xddi2WZbjYUYWaodAfrb3iFki0NvNcrNy2prlfvlaO/M6vZ5i4u9hbF5kSEjbPmBZzR/PSKl/IH
 3pbe3n3bPQ0102k9EApQMYB3doWQ5qlCvSBSKo13Qi4QFAMpN3WIINQfmiOGJN1SVzZe65JnSTi
 e/CS8hr3Wmq8JLA9XeWG1fCLx+pgkw+elswAEvYBoTtX1v29J1BXdYrYOKDeCowwstldXNlcsEn
 Gk6oDsFZyYZSaIGngNXnAPfKtUPbeNFvH/sjxhw2M323VuobSBEeuYOv/okblUweYUdxQNl3gZg
 bEmKuZwibc7aZlHCoMph80ri4cs7Aa9ESTxnuW5HrCJlc3zcL44C0b6oKSm47duwuHCsjPe3pXE
 4C5nv1LaMrjaYDYRRXg==
X-Proofpoint-GUID: bBZfsiV64WdsU_BYm0VZudciz0-OSylc
X-Authority-Analysis: v=2.4 cv=Vqe2kO2n c=1 sm=1 tr=0 ts=6af69776 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=GP3zSRAhaBPBpq4jRjIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11-11-2026 19:36, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 04:13:53PM +0530, naidu nama wrote:
>> From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
>>
>> The Type-C mux switch guard only checked dp_powered_on, which is set in
>> qmp_combo_dp_power_on(). However there is a race window between
>> qmp_combo_dp_init() and qmp_combo_dp_power_on() during which dp_init_count
>> is non-zero but dp_powered_on is still false. A Type-C orientation change
>> arriving in this window would proceed with the mux switch while the DP PHY
>> is mid-initialization, corrupting the PHY state.
> How is going to be handled then?


With dp_init_count check, mux_set will be skipped.
>
>> Extend the guard to also block the mux switch when dp_init_count is
>> non-zero, covering the full period from dp_init through dp_power_on.
>>
>> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> Naidu, you are resending the other people patches, but the SoB is
> missing.


Sure, I will update in v3.
>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> index 61d8b7a5ce8f..3f93043f94e5 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> @@ -5163,7 +5163,8 @@ static int qmp_combo_typec_mux_set(struct typec_mux_dev *mux, struct typec_mux_s
>>   		return 0;
>>   	}
>>   
>> -	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY && qmp->dp_powered_on) {
>> +	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY &&
>> +	    (qmp->dp_powered_on || qmp->dp_init_count)) {
> Can dp_powered_on be dropped then?


Yes, this can be dropped.
>
>>   		dev_dbg(qmp->dev, "typec_mux_set: DP PHY is still in use, delaying switch\n");
>>   		return 0;
>>   	}
>> -- 
>> 2.43.0
>>
