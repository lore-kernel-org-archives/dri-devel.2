Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59789606B551
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XKP49g+E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b8VRJQVq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2851122F6;
	Thu, 29 Oct 2026 13:38:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD99B1122EF
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:37:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCe1CQ1147499
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jxn7SsojnXA5TK+qHLQ9eCfFXNVPdhVIuJ5lM3etGbQ=; b=XKP49g+E1V3HrnjM
 OLz2cPTX2f/an3poZcEYQE8Z+1+pHpYNnk/uG9BOXs7EdPPMigtPBqdxwx6UzsVo
 ftyIOU6RPOaqISQKjkiv+QtFZirtbtzmUwSjgxAhTfNO3PAOm3M6qQrK5hLpsbn2
 0jxfdGWQlqTfaElpWOImtGOPawamcNhZxiZu468zpSNisl7NSbQd+fXRRKzsV+D8
 7f7T1ZgMsCWSUf9VQJF7jswZmu98oK76ja+aPjvB9zXSzrMHmJfvH9ehvvBiMpkA
 8iUULKI20Fu6VpuSeM73jzHpIaj0ommcULuBG8Li6IfUQi1PUBQVtcKq6P2auEFX
 ua7l5Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q8pnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:37:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ea6b66e53so41579985a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793281021; x=1793885821;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jxn7SsojnXA5TK+qHLQ9eCfFXNVPdhVIuJ5lM3etGbQ=;
 b=b8VRJQVqTA73dSecPTul/fZZJSB/ChnuiBOScspME+dqiAljHhBmB57sbEbUiCAOFV
 hkGrEBY7nfeOwWZtCWwJaCl9PeFfo3WELnr2Md0CVcnahZVaIpQbAo7G/rYkOxTiSzMf
 xiIBS5o1Se9R03oB2CnQQWNX6AsNxSDLfIigmMGlFArbAzmwlwuuYb57700a7ypEDITL
 SLlbJ8tjcnYHu/mjk9eeS+YfF5hJq7u6DBFDzYaEpkR09iqYv1eEWUYJdE+4RUDE/Hbp
 KFrIGm6OCWAequbx/eSWK1+lrBIdyCvOGpdAv3dr0seeQRybVuJaY8ajPNeVBXIfrWLr
 PyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281021; x=1793885821;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jxn7SsojnXA5TK+qHLQ9eCfFXNVPdhVIuJ5lM3etGbQ=;
 b=QoIeS9mmH4iznJ015dFI8V7rOqN28QEElMeKAEZ8D52GfblpjFjuv3x2I9rDwe982w
 zZo0kqj29276yPIMYQD3wPPL7O7BMSw7gSGpls9jCnTLpsVxDYZzNPEbAiKzo3Pxpeht
 I6iHZB8q90Uf/fXHzPNBEqc352aEBar7Gd1fXa6V765lmHoZoReIS35ihith3OzGFVDn
 84e8l3iWMj79wgTCVwBhMQY3heLaLoGnt+VZa4Es8Xp9Cxmr0bZ4UJjm2W50vJMrVqb0
 yv33SO6Di7PGeaEQzWXIeuV6y2/4VJ5sfJgXiPsn+diL74Jj4m1ztFBrE106TwH6HNJr
 dSxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZk633xwK+pcKO1ILhXLtA5vp94DTnJxAyIuv1a4BARb5OTtLXWGx0x/8lZqfr8SjmXSmQQQ5X/sM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJMHBXS4DrOVG2sagb8ufgcweWt2t5QREZgaPByJpHWJ5Vyc4CK
 67Vns/tmB8/FFHCKbymCtIAo1YNmsjEvelg9mPJisT/81a4t28js9ASDusRUIBKbs74/FCmtXfR
 zWeUFysNDLXM61NYtUPCR49/qHtAgCJeL9I2NErDmhAYBaSS/K6R7HYIzUtyeDN0GFEWOx1c=
X-Gm-Gg: AYBFou2Hc06mmjZELq6UwgKpi/6XaCYq/JPHoMak6C5PeYsTyd5nJ9Nnu6FZEfFOchb
 x2ndaiUdc/0WYkXDiJOi8PGb52mdlO4uauTK6HJCZMXoY2i/+MHLOEJJEeDEk73rUGDElrrTRBK
 BnpjMpd3ErCJHF6JLYVewFSk6O0MblJDSShztlOPBcSrlOKRSWJWGv1sbECxvZz53if4+rlqBjQ
 GwnQcu+qtVKbiz0tzHEuNPcN3wvEG1fZGivpStwDmBZIJoFoUS2QnBofhVGRXlPUC5m8XiG2G2j
 I0ji4I/sVzf+/fuY/9qdE863GHdKeZm/XibEr1IEVfuPyIkj8o9ZKiPfNNU8ckh5p9m/pzQNj/2
 YbwbY2wi0UIT0TJJI8KuBdA2aUCzLdmLg8qcCM6sHdz5gj2tTQFwYVPcBAStB+pF5SBzSHag=
X-Received: by 2002:a05:620a:a8cc:10b0:93c:61e0:81ff with SMTP id
 af79cd13be357-944089b232dmr755695085a.1.1793281021239; 
 Thu, 29 Oct 2026 06:37:01 -0700 (PDT)
X-Received: by 2002:a05:620a:a8cc:10b0:93c:61e0:81ff with SMTP id
 af79cd13be357-944089b232dmr755689185a.1.1793281020725; 
 Thu, 29 Oct 2026 06:37:00 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c49a50c434asm416606766b.5.2026.10.29.06.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:36:59 -0700 (PDT)
Message-ID: <5ffe4da4-b5c2-4e24-9418-1edeec777932@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:36:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/msm: move VM_BIND op validation to Rust
To: Alice Ryhl <aliceryhl@google.com>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
References: <20261026-topic-vm_bind_rs-v1-1-6581465f2428@oss.qualcomm.com>
 <auMWZyxtC1d_BUgN@google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <auMWZyxtC1d_BUgN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX2BJnrKKGVI70
 zpmmQ6AoOmhNqyk8+C2TI4XYMY4Z9dIFktiDHwbklP/zWzDqL/zKPZbOJFEhc7nRwBzgoeQyPYX
 JTLjl5/i8+shfKZC30KabQvZOE9sEhE=
X-Proofpoint-ORIG-GUID: gKGeh9t1HM9nfXpN2r40MRaK-hIr_Chl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX6YsQYkcfkPz9
 oma1dHsBiLYGUP9wP2X8GGBTUv4FpSeUJzYm7qWy56GSwMNRzuD6On5R+FTUzhhq7eiIeS1HWDw
 4r01bPuy9qd8UpzlBl3/i3VKD27LsM3F8a2h+y7IsqjB4vbdu5sPVdQRqRExMmv7hpKGuAD546g
 Uq9+xaiFVU1y6B0+vpKuihd8j9yiXfDRPvxWghLD1A39hpHwq+C193hro2UWEp3+pN8UlILEVC1
 PThoDE08uLWY48L4jYT2vrE+C6xRiWR/wAvhuJNkeRtU2YyZjtbqyikRFxijXAJPllWuxI25crj
 aR2VnyWryVJvCyX74JCZvVwXjCtWSU7v+R9Cl0Nmlz1zR8YeRP7TqKc2YkiFI14dV08etdti6/j
 4IL8nSl4Wh3bNOVERshGNXEQKkAnPTXU5oypM8tnKGgRf5PilDMNX0ktUX4puNia5oMRgoeL3hu
 /WJtDz+dXKwLzMkxbBg==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae34bfe cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Y42vabP1fUe4KHNzalkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: gKGeh9t1HM9nfXpN2r40MRaK-hIr_Chl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290053
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 10:48 AM, Alice Ryhl wrote:
> On Mon, Oct 26, 2026 at 12:40:02PM +0100, Konrad Dybcio wrote:
>> +#[no_mangle]
> 
> If you use the #[export] macro instead, then it has the same effect
> as #[no_mangle], but it verifies at build-time that the signature
> matches what's in the header file.
> 
> See for comparison:
> drivers/gpu/drm/drm_panic_helper_qr.rs

Nice, thanks!

Konrad
