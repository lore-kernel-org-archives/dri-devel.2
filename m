Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C82FC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECAD10E4BA;
	Tue, 28 Jul 2026 07:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLLBNyM4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CpJ95F6Y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925C410E4BA
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:10:54 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aXPL1303438
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HmWG3QTmOnBSsr7ji3RsIoKz
 XkevaF/neS5MK/vu+co=; b=gLLBNyM488Sns2hlx6jFPKHgZvpN2pYKoAJ2SBQQ
 Qa6jVXobvr8IU9/q5KCJlifxnGvSpcQhMAejnB6eFB1pvhSCPGiSn+fUGoxzQPT2
 ekCl7udLoA2iK90njQB2rUZfEu2fEBYAx4s3lS018CPEwLOjpwLhjY9lOzEeg2b8
 tQupFcU5HadQLWcLRacwOZBPTplwwN+1w56DgiYAgLLvAd/tCkVjslD7mvWxRdZ1
 Op1Vz0TBbQbRxhKxQjaHlyLkhkAWdo9MW68hrTsYmUgk4bxJkuPfM0lBiH9C4kwS
 U1e7ewvQVVFzdXMGG5li0kTjKNlRmFc/CuOkcwBI1gTlqw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8b1da-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:10:53 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so4031054b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785222653; x=1785827453;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HmWG3QTmOnBSsr7ji3RsIoKzXkevaF/neS5MK/vu+co=;
 b=CpJ95F6YHH7Azw0kQTTyqPnOzLMY5gd8y2VQXrstk0YkbHEF43Dy2bsonFcGU+BKnR
 PvP/FXDcHGVFTIyxuQNIeKLBabVM4dwgo1eN2+4V69CNjLEIGZjrWoo3V8Hpgw7q4+4h
 ozEnV3yWBGrsuaGxLcR9X6h8wb9YhL4myy0ELdOzYCzxczytm1Iuk2gqniQ1GEzD7tmw
 A0gffN7wODNMuXrzcuvz4soRUV8VNCcTXoIc01LUrULW3XCqtlK0AaYYUGYXWN4FhRKS
 jTesGG7NeXwu7oslHGow67/vExqioNa9rlWDfAkAZKqI0J/Fy3Cwdv1Xk9VLxIMs9g07
 fVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785222653; x=1785827453;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HmWG3QTmOnBSsr7ji3RsIoKzXkevaF/neS5MK/vu+co=;
 b=QxIUjLCQc/pi8FaLzyFz3bwbxk+CWiaWHwjsqyVkEeVCos4WFlRiQkm/R1iXK2GQ0h
 OLH2uC4uNFylfeDUUDgB1q5AWYESko6q91xvWgZT4PY8isJUymXAYa3nx616sDjNZYnO
 MLwv46J97MXj2HjCgv6O7OGgZz6MbD11Wt1QBqtLspSbOKarxpwNHxwPDICfXpaDUZJk
 litjCXycpaTOCnbMykkgKZ49SWPXrqFeUoi7M57FO6aJ0+mN4vDgY4vTAvBSt0/LY4rv
 wcuJr4lU03LERnOeX3JL8HMMQUQWw0dBQceAvfZOCe5zmHDTPWZK1rZcgUkvnS3bGm49
 l1Mw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3bgTHr+TCrbowyZnCfrp0TluiBT4JQM3qXN8wlDBXoZ+i4AkVdCGvD0DRkn40mPj38zc4OppUPnc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznxoBZGwxvXYI7hfCT7Qp8mIzATW+YPPbR94z8d4uqHhZPUyUO
 O/AD5NTOlG/JDcwuotjfjmCh1Pe8KaB+JXbDv3peESTOAOCJ4sEkPGWWdFvvEQ5kQruhNlmL24C
 SaK0fk6ZGNqpJ8qgfsyWnE6yQGekPXjAhuELdTRVV4i42+Wetpo91C2Ajoq9UpJqCfwvD9Vc=
X-Gm-Gg: AR+sD12fIwxgAfWulacjX+hEjzx8czPg4LbubgGJdXG3lHbPU/TaLUryJ601xHbqaa7
 XyfwUmFlhPT9QFXfrd4MzHatu3N5lTnae6vIZX4JD4jzMvqyHO7wyRFePdY4i46SloZpqKdI15h
 VTm+hba0eN9MGOR1+mPcqB98vZ9WtrnReTnIJz2PUKm4fiFqvQT1BYpNkoK5guGXos2eQXqAPAb
 HCnSfHiVSbdBvUlx29Ttcn2HB2mPbjxXL15r8VPB2HQvWpOqtR9t2gLMudnHvojRwE4sMa2Ta+h
 SUgiPzH4wQcI1FWzqYqNw3YvktDjd+mEKsfVJoZbq7s4Oy/ofyFiaKXNedZfZqzTImeyQ2ebQYh
 Gok3FiphkWbg2v4aElxxf3VaZN69vIEgiX3EJY+vGrlQ=
X-Received: by 2002:a05:6a00:3c84:b0:848:6dd1:8195 with SMTP id
 d2e1a72fcca58-84e9332af58mr1188307b3a.34.1785222653231; 
 Tue, 28 Jul 2026 00:10:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c84:b0:848:6dd1:8195 with SMTP id
 d2e1a72fcca58-84e9332af58mr1188280b3a.34.1785222652756; 
 Tue, 28 Jul 2026 00:10:52 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e533d13f0sm3980391b3a.35.2026.07.28.00.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:10:52 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:10:47 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: Ignore unsolicited DSP response sentinel
Message-ID: <amhV90DXoo7l8XUD@QCOM-aGQu4IUr3Y>
References: <20260727130940.577721-1-shengchao.guo@oss.qualcomm.com>
 <3a83e00a-9e4c-4411-b554-1edb9d02c799@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a83e00a-9e4c-4411-b554-1edb9d02c799@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX3u2Kp9hAFPNw
 fXwJQ0DdfevM+tVsmtUN8xVAesknMgYFJ4pTMkUQXhP7nHjmvbBJ+p/w2yKVyYv3qxzPBJZuNiR
 cLfiGhT/kl0PygKcFfpHKgusscgDX94=
X-Proofpoint-GUID: WV-Ftj1jjo5rHs5zIcOEZfGSpG1Ys6pD
X-Proofpoint-ORIG-GUID: WV-Ftj1jjo5rHs5zIcOEZfGSpG1Ys6pD
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a6855fd cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=L035sEZy4BSS5_ho3PYA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX1FUNQ71Uk8zS
 AvhCy3UpYTg0jHVVKFR+REVrGAV2QhDWAPYHxgWydv1s4Ro90TJBtM26oIs3L94V7ecPaDLwCW7
 +XU8bwZ6cHaqgKWbvMNJivUyhNcD0b0nM8ApWjDXqS8lACo4+UZophFzblQRvIjT26pu11JyXtz
 yQw6Rt+HSbWOG5OAd0TyBuNP4vVyyHwVQCtAdNTRvbd2q4PKYGy6iRQRDxMNBwTLgXbka6DVzhp
 Iz1B5yugQZOWN7CfplBWwLmnYbkaMq5mr8QdNZirwIkguXG9zGKe8gHTTeDYVIQVnUnhliNEpFR
 FuZFv3+iN+wq7FUQDBSSk3cT3paBBAvG5f/hwFtvO7B7iqcj9IboiNmGFJtslMikHfkdU7tFRjl
 czDHmMy/OumPK/gEwcUEWY8+Pr8xC47wegUQoTIX9wTG9+t17NRx0nSFRGkWwOd3oQVZB50vrll
 NjsMRQHa+5fx9cfRc4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280061
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

On Tue, Jul 28, 2026 at 09:17:34AM +0530, Ekansh Gupta wrote:
> On 27-07-2026 18:39, Shawn Guo wrote:
> > The DSP firmware on Nord targets emits an unsolicited glink message
> > during process teardown whose context field holds a fixed sentinel
> > (0xABCDABCD) rather than the context of an outstanding invocation.
> > fastrpc_rpmsg_callback() treats every inbound message as an invoke
> > response, so the sentinel is masked and shifted like any real response
> > ((0xABCDABCD & 0xFF0) >> 4 == 188) and looked up in the channel's
> > context idr.
> > 
> > This is not merely cosmetic. In the common case idr slot 188 is empty,
> > the lookup fails, and the driver only logs a spurious "No context ID
> > matches response" error on every teardown. But the context idr is shared
> > by every protection domain and the listener thread on the channel and is
> > filled cyclically over [1, FASTRPC_CTX_MAX]. If slot 188 holds a live
> > context when the sentinel arrives, the sentinel's return value is written
> > into that unrelated in-flight invocation and it is completed early. That
> > is a latent, timing-dependent bug that just does not happen to trigger in
> > current test runs.
> > 
> > Drop the sentinel before it is ever turned into a context lookup.
> > This removes both the log spam and the mis-completion race. A genuine
> > response can never be masked: a real context is (idr_index << 4) | pd
> > (at most 0xFF3) and can never equal the sentinel.
> > 
> > Lemans and other targets are unaffected: their DSP firmware does not send
> > this message, so the new check never fires.
> > 
> Sharing more details for this context:
> 
> On newer firmware, there is a support for DSP PD notification where DSP
> sends PD state notifications on certain states as per user request. PD
> exit notification is always sent by DSP which is with context id
> 0xABCDABCD. As of today, DSP notification framework is not supported by
> fastrpc lib or driver and it's safe to ignore this callback.

Ah, great information! I should have consulted you internally. I will
update.

> With this,
> 
> Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Thank you, Ekansh!

Shawn
