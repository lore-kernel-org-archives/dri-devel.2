Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8A606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D4A2rRQm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VakYS4n1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB01F10E200;
	Wed, 25 Nov 2026 08:46:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC5310FA2D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:46:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP691vh3261801
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kKvNZULobWTkgnWspQ6zXpMU9tDRDqB+Try7/+v8+b0=; b=D4A2rRQmHNjsn9qZ
 7CGgn+x/QEBQ43ddBcy28LJf53/3XBPIFbXlptTz2TKlwprHiA9KsIuQgmvmGOQo
 uN9t77tMbJdBP+SUtQf1buggw3Me8N18yqTbqxY1WI3uwUcqUJnP2InkWHaL0Vsj
 40tHf8swZu+xtQT17OB4PLI8w87Nhj/yijS6AGTfTVYMPuMHHaicKZWXUskdkmFf
 6h7/KXDRZMXzz+PnEUxIqfoYrS8Cecacium/klrtGvENWGrGlx7cTFvqIHW3C2bC
 03f2FGD3YojsjhTdmwx1vbXrqIHwIR7RWm5TWMIy5f28bdjLBUfc5Ldu6/PQA7TL
 guJWyQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egsbax5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:46:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3b42c3dba96so6476042a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795596394; x=1796201194;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kKvNZULobWTkgnWspQ6zXpMU9tDRDqB+Try7/+v8+b0=;
 b=VakYS4n1vcnVHj/CkawLE6EsQk++8yoJ67ybToiZLQcEP1tHwxs8rxZYKdRBLQP19V
 YpH0ZPFRHohf2wk7c6VDGkVrM57BEMNtwFLXWfjSVIupjISRDRIpVrQcHp2QM5Xw+wMd
 fwI9B8A7PxJDionk9Y0aTVuA445tDxQHfjddsda06oUo7IEgm+tGAUiwQk6Jvfj7yzhs
 fJwk4plgdv19+BuiiF7u2uDjZwIJQ7iqjYdrMSl2jF8d9ynI1CGjCTimjLCk3uJzsjXH
 A5XzPRrTE5PcdEE5R1VQZweSuZzaXQP6oPCwwDd1PLz94ectvNbYQ9E/Lkcqnr0K9Mza
 4jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795596394; x=1796201194;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kKvNZULobWTkgnWspQ6zXpMU9tDRDqB+Try7/+v8+b0=;
 b=WSA0OddiJ70nlJnSIQT1YdVufPgpDsJNh9+s3WzhjzwHoVXV8r4CCSp4VqapdVdi3k
 iV1xZ602N5RADBBHTy9U1UciMsdYvmUbdNxhnJfD6SBJleNJ7HSmVLZnGlVsNd7vJDNP
 Esvh5uYVAEIhleNLYpHGxWqUEJJ46PaH1ajKUftAxiqpe4si6O5j2ePUUyzuQKzo/BNS
 N2hazCgOHiEVhfngJOfkHCnNSTjQrCbZgUX+i2yp6rjk15i/9WABYfef/yxL6kfd6cHL
 fvKNtEKQ+agXKU9zT0B/UCqhZ/2xWJatkB5pQjz6JnakBC0xmOjQl75h9HTHikyisKUX
 +Uww==
X-Forwarded-Encrypted: i=1;
 AL+hErFsd5IF3m0wUj13d40AYjhZK7Noqac/0Ez+6iUpHPvfQF/nA/XkSa7ue2jjrU0BX/5pW9LBtq9GtI4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/JU37grgCB+haobBZFV3BUcWeIGVrHA789IgRnvSOljGpjJDns
 eJL1nChcGoiMyQ9dIGrWv/nCmqLtKzYtbdWIyXpypXJ83fOJURXuL01iMez0tvrmFGM2qeT5PpT
 a3yfH92aHkkwlN07VNuAdvFsmwuu5+j1AdHs/A/1+ig3MGwZlyWBpHo3FUrdMfXrzwU61hrc=
X-Gm-Gg: AZFdTZcyLPtwA6hBVTJdMEUzdCz0ZY2nttsmXEdpIDf1ToGx1kJmRI+jX9eRvlJmDrd
 QrQoTPMcrs4xRnLOlKSsqrTizobaPro+nFrL9JfZXqhhV8oxJZHGicobV+SE1kxeFhO7yz5mFI9
 HFzsxqtqD0JLtMz5W4vF+RAqzpLQE3xDLbnNyXZEw9rHbSH04RBcc6WBVAtakQ8xy4cvHdBcHfG
 YHLsamfUB61y6orMEBlxQO9DF0f8++svPWx+BNa+waGxZ8bgdr+aja3FXMBxIagWC7XtUhR8RLr
 bID8xdBMbW4D1y0R7UiDEeYvevHlFO/Qtl7fcydAFbFkN+2UxsdpxZRhEmOzUKDPL7hCdVLJurD
 vwIH6zIJfFiwAQ8b2gSZx6g/yVa9O6sub6DvmQjMOh9XN0/FkTpggevGvmF6Xx9XYIg05zgKj+w
 my
X-Received: by 2002:a17:90a:d2cf:b0:3b4:d22:8600 with SMTP id
 98e67ed59e1d1-3b41c8fe1e2mr14881277a91.18.1795596393897; 
 Wed, 25 Nov 2026 00:46:33 -0800 (PST)
X-Received: by 2002:a17:90a:d2cf:b0:3b4:d22:8600 with SMTP id
 98e67ed59e1d1-3b41c8fe1e2mr14881261a91.18.1795596393472; 
 Wed, 25 Nov 2026 00:46:33 -0800 (PST)
Received: from [192.168.1.12] ([223.230.5.36])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b495035339sm13872331a91.0.2026.11.25.00.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 00:46:33 -0800 (PST)
Message-ID: <dfb34991-ceb2-48c8-b1a1-bb6d07a594e4@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 14:16:22 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/25] accel/qda: Add Audio protection domain attach
 and its remote heap
To: Arnd Bergmann <arnd@arndb.de>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Srinivas Kandagatla
 <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, rob.clark@oss.qualcomm.com,
 Jason Gunthorpe <jgg@ziepe.ca>
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
 <20261102-v4-v4-21-88f2f24a5f0b@qti.qualcomm.com>
 <ab387dce-fa47-4fe8-90ea-d0b8013d01a6@app.fastmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <ab387dce-fa47-4fe8-90ea-d0b8013d01a6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX7xJBmnzU/ffc
 D0Ih8ybKUWO0pClqYCfKLWS+trW3tIl7SyPW0P7Ze1A3SfFyEfSco6R5edimqfWbUEZjrOjXzoO
 k5HXRM3QRiD6TCaxw5YDQolUanKrab6nHrI2poh7t/aXINYZGccOmVLDKLCzeQOA0acbqFyH/hP
 L5Jk2YCPu4GNDdZcTIIYpE+KN3SGKze/VpR4XXXZ9QQZ8KziAeZzfV9sjFQV5ZQB0iRGCMtoPUi
 05ASalFw2ZViNAQ5cuNda0rLbnuNah3mUzAAznqYvDvPBL4hlil/Wl3YwMrrBrTHzOKs8pC8jts
 1Urf8O1sNuSbMxOy6XWlP8K3uAFIkCH8X7XsQL8uAlRloBt6Ea09222DA+PlT9J7gzrakSDRpLj
 bQ5LCWB5IunYmOgrpbyz5IySwKaf08kiGuy9K2Ts++JuCbIm3LLfXWeBfG0V7djPO3sL1Ywjnn3
 c0ZAhvRM9HQcojIY0mg==
X-Proofpoint-GUID: Cz3gV6QYrBSOJgJ7XbRDsP6hww-jKbl7
X-Proofpoint-ORIG-GUID: Cz3gV6QYrBSOJgJ7XbRDsP6hww-jKbl7
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b06a06a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=7CQlB+x2kvO/AZ184d7fkw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=JiugtRSXLg-Y64xyin8A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX541lehid4WTs
 SxE3wSzS8wqgVPUclAzbKD9V/gjcNem/xWMmN7iocB24t/tZE8T9dOdgF/Cj+yhE6bvx2I6dtFR
 VwitOzkep0I+K8TvZqNP304/qVtDHWk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250034
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

On 02-11-2026 14:13, Arnd Bergmann wrote:
> On Sun, Nov 1, 2026, at 23:21, Ekansh Gupta wrote:
> 
>>  struct drm_qda_remote_attach {
>>  	__u32 pd_type;
>> -	__u32 pad;
>> +	__u32 namelen;
>> +	__u64 name;
>>  };
>>
> 
> This is an ABI change in the middle of the series, which isn't
> great even though it is harmless as there are no users that
> would see the initial ABI.
> 
> I'd suggest defining the structure in the final length
> from the start.
> 
>       Arnd
ack, I'll define the final form in the patch that introduces it
