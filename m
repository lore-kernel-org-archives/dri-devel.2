Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79F606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X3sqnMC7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27F0112838;
	Fri, 27 Nov 2026 08:29:16 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4499010E992
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:45:41 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2f037bc348dso56551025ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 05:45:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795700741; cv=none;
 d=google.com; s=arc-20260327;
 b=fPvX6kG0VJjSq1+N2Fh1LPa05W7931XB82NB/Vuv/xqcu+UgmS4wK/wNoBy0+TPA2Q
 xSUMiu3SS78zl+N1+fDhqXNtEzWNnWXXeGiouv3Aoy4tN5uuzEPLf3uW2LkcD5GERMLk
 vglJmlfwZoXKDhW1r4N1dpfWru64LHeQM6bsTP22ONYmiYyDWSTjXUMuaoV8IqBc/7pr
 zBA80wpoY7PTanbhx7PjJOLYJRfCNkfESTUP6SQh7VLxW4bNA7YlVEVO7ou6rUagy6WO
 CMHkZCCT6L3o+XF8xos7cCfv43OZ5Xpin6w7Ox3nbUN1Y54vn7660wQ5Fv2vUxh5exNe
 3C8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=T5ozkMuS+gRxSf0euaLEG2dWjzTGlHk1oqOweek7WHo=;
 fh=ujQEhiKeMRZqzsOdPmHDOTX2i+Rdpg0SJaew3pzyxmY=;
 b=l4tqaSck6gqa3pgOdISBQam0evwbl9/TdC2UJjhtnone0TsHes2SK7RJbErK7z8Snl
 RLdft+omfiT/+6yF4ptf//1i8wQPqq922I92/2FBh/xUb6448FHprCHdXjS5edpIovxT
 AUY4SUhaATVL89GTv8vPr+46XorQfDc5VWxS8igJVbdftd9bBuOMi5cAHdaiiOuZssvj
 fkP8q/aiW3Di1IcuX43t+MQgqEgfFFKlQ/RLT4/c43zvkYGFtZzV/OjxIiDeexuq5lsG
 cSq61AWhnCin9fae4kaZfLAUyds9DfDrO68MuuolJRhuXMiRc3DOA7H4QUlVxPPAV4c4
 c+IA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795700741; x=1796305541; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T5ozkMuS+gRxSf0euaLEG2dWjzTGlHk1oqOweek7WHo=;
 b=X3sqnMC74ia8QFJeWgf44kaDZlfaYQwVuad/xzq0Govb5WyclOJiSNPlv39kmO7mCZ
 SxBXcTAtcGTvhvX9KurvvQF3JYaDz8rC6XFi/Wdcwzkwb1hHZZ4flTn4kSFqqkyVzUes
 d/F3gHOBOJqfIv9+txsM97jIoQM8rujHmgXrXuHgZcGW4L69r0JMsF4GDaW7BcTcwYeJ
 xMErEejxAykWfGqx3fiGffOXikn4oQgl0Bn2HfTz2hWJos0lHqu6QFAFiZPLV4JBcwEN
 q3ukQ51o+++uIic7ITHI2LoeHYH6pGOgIAt+TbzuBnEY0X4vP7O+GPRX9OrVj+JTOqJb
 fPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795700741; x=1796305541;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T5ozkMuS+gRxSf0euaLEG2dWjzTGlHk1oqOweek7WHo=;
 b=hgSdQAJ77PssYuSHEW4I/POhc/AQ18h0HXOP1yMkQRynGFy/G3A3bxWTGOhzQXViD5
 lsAE8dL+le/PuCq2d/MLrYzOrhQcrZ8NgweC1TcBJBe3vlHh/JbgXx/uLX751hwohT6S
 LAeEUPTekzpArtQpfYorM9UL//F/1b8aJ8nQoC1KvEJLAItvAj7rStLR9qvqYDqCial/
 WtAcaQTOy9IUmRSnnB0ZrW1MVN8Y429isBSAqrrRfj1SyRs4JZcMtVM3JRz5KSwyReEM
 rBZ2NC/frPC+NwzyFcZk8bdwmWUiaVdaPvlNC6iqgYWLFfMDggIXbUAcNDOI/i5IXITv
 4tcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFnAbTbQu8h7DKYF5bF+hkDYo/3SzTGI0BsS+tLnI5qGykDYLM/XifGKfE/DH2m6zNqJlBb4W4NcaA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9GoT+8nV4nWLdlMWA7My34/HvMkKgG8xI2RtSqMcqU3XYac2gR
 mQfYP8uYxl2gWLwyz5Fh7j3sjp+KUbaLRtnU1He9+aqcDBGxlgizU56AspKtP84L0n2ooBPBDIx
 lEx1CxCF1H/Nf7Tb9i9gCHK8ngO9azr8=
X-Gm-Gg: AZFdTZd9b3LwwI7h9807yGf6furpf16vCWxDgUTbudeaUmaBLZHfnKsHgS8eOgMnPiE
 EPSqCH+rilqe5Py1lDSWTDcI3O61hXjmXM90Rj2xcksbmnyRbH/eXeXEgFTJjSI8NUF8z5bhgR6
 wbUP3GvEZ8Hp+s33ZWlJgodtZySEoiSiSCtG+GhxKDLQNrHtEZw79KcZcF5qkYORrKzsk/LPXl3
 76oivRfBaxv/6+71A5BMYt8rw8sHzc+2K+AjzRUB/k15pobD8wNvGcDy2mdimNAt5xm/rIxAW18
 izFRmfvE84NQPZkSe1WT6Flf4e05qX0jxAEhdmjUt0WcBgnv8cpK5WtJjYAVQrbOwobrpll6k6a
 ByHc8a31lrZGNin+NOUES923KDYqjymK9Z3XYPgkYAvz6cpS+YMKhNOAWnVqojSQ3ItEhTQ6tkR
 4kBHc1OU0C1faNKdZEKsuUf1tVbzE=
X-Received: by 2002:a17:902:cccc:b0:2f0:d976:651d with SMTP id
 d9443c01a7336-2f0d9767d6amr53268915ad.14.1795700740738; Thu, 26 Nov 2026
 05:45:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6a11:2c85:b0:777:7ce4:67b5 with HTTP; Thu, 26 Nov 2026
 05:45:39 -0800 (PST)
In-Reply-To: <20261125-crosshatch-panel-v4-4-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
 <20261125-crosshatch-panel-v4-4-120adc58e737@ixit.cz>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 26 Nov 2026 14:45:39 +0100
X-Gm-Features: Aa3M54priinoK4RB9S0Qcbm6WAFnj_qItFpMPe6AN6BknRsh3QWi5LoJ_bUL7rY
Message-ID: <CAB1t1CzQYye-jBeUMUGbS+famevNK3oqsDg29gTV==N7DDv82Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/panel: s6e3ha8: Prepare for supporting
 multiple panels
To: "david@ixit.cz" <david@ixit.cz>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
 "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000c650ef06612e28f7"
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c650ef06612e28f7
Content-Type: text/plain; charset="UTF-8"

Hi David, all,

LGTM.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Petr

--000000000000c650ef06612e28f7
Content-Type: text/html; charset="UTF-8"

<div>Hi David, all,</div><div><br></div><div>LGTM.</div><div><br></div><div>Reviewed-by: Petr Vorel &lt;<a href="mailto:petr.vorel@gmail.com">petr.vorel@gmail.com</a>&gt;<br>Petr<br></div>

--000000000000c650ef06612e28f7--
