Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23E606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ryQ8lEkn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B74112846;
	Fri, 27 Nov 2026 08:29:22 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09A210E9AE
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:52:52 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3ae7626d14aso3512005a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 05:52:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795701172; cv=none;
 d=google.com; s=arc-20260327;
 b=Ooeft8Z/v6bHdwbwzkqFgNxF1JKZKEKzGPnRwovT6RpeHZktO9lQTacEOnIncJBi+n
 jxUAlNcWLDAmXmwuR+upIKxJADrythwQRQPqtIcQs0vm5Pn5mmwAZGR72HTX+qU49+zj
 /ZeHiurGBL4pJi1ImXcNpOcM7/2r6gqkwNxA4a8O7bbcFFGfNaYBTOvg+4wbfYKjQNhb
 6h9Ynzwcm15UberOuXiZI2PfHu+UY4CRkzLI5PAZ+Io+vVsQzZeYyAdGd9j0myWZBi8X
 OG3WxPphIg5E83hpyaCGiGqJTu61e8NU4iMdVCRwZXYTtOJCKYhxxzzlzoS4teTyLkmD
 18pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=cXojjGhjzotTx3N3x3VaFYwaqsWaENj49iYghLkHUfE=;
 fh=6XzxxGJRVwccVs4wTqpK+xrGDKg4GRnQg09RhjJWtOA=;
 b=SdrZsJM7MowHIGpaaO7p/cmTmEoE+tTqMIPEeOcmDTBFde1aKzeMGTbMoA6g+INo/x
 YtvQ/fjp+ZHS2mSctG9jiGpnWNbH7eU5U/xT4TmnKpbmJUyz/Cg+wqMGMpN/5M+bW5Io
 3jJwuLGBNrHaq8PZ2fmchJZZ5lTr3W0oRDpSOeHz7ZRgIWTUAqkxRC9pQLRcamGk6K6X
 qQGMWUboHWJTMpGWq10i58dqpTN659Dvr8UN61RhJS9r90DyjYShODZ28dJT9J5Fmgvg
 dSk773cr/T/WopO+D7X9Uz7tq9QFjTYDJ7pm0YevNxLd+uq8YNUmQ/oxWWk+p9QkV13O
 fKsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795701172; x=1796305972; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cXojjGhjzotTx3N3x3VaFYwaqsWaENj49iYghLkHUfE=;
 b=ryQ8lEkn/EsXRZHR+xnq7lDmiGehRGxzr57lYzvko5niYv0tuJr/PYxKLzs0eB+R/6
 S88fGBDKuu/9v3gcifClngYrTbivNXtTgWXXYkVX/JgVWqR3zp44WjJND4TRUzvrPyBI
 oIV2DDJLRXjcU9TWGXm4tHSoSGXLoBy8Kyq9X6EPPJ+8Jk/XTdIWRhjqWJx/E6qR6VIa
 OWPc00DR7BQlbEydMTd1q2QmArHPW5UWZqQlZA/OtYAunjTsS47yEEup+r49QvLCJuY6
 6kCapkTHUIAnddRtOqO51Qieai8UVjZFtu1XN0+VlHkLwBGOtbE2MMwTl62MLnWVgWXQ
 FT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795701172; x=1796305972;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cXojjGhjzotTx3N3x3VaFYwaqsWaENj49iYghLkHUfE=;
 b=DoolUHZfwJnRhmV/p4KvRQcpuyOWt/memqQptNOIV/oIgsE5PjxmArsuCdUqyeEiOT
 iL9taVh0G9i1Npp8d/grdQ4cFrpsctNHXHaN5d2oG8C9L8a/Gfz/Y7zaSNjEYjt5LOff
 Dn1h6Z5mZ1aNm39Y5DuiCzF3GWmV+Ki1gvsO5MtGL1fLRIIfiTTaCzFGO0aSlaBcNkk9
 QXpdL9s6pTh9cVjnPWT+4G25IutmqKPkn+Pjp22tUeH5i4PbTjmAs+W60PKGnN+ynFuD
 vUmCO749wW6MLdfohgBbWA0RcS0JblzSpETpn5Z6Koc8gp+htqahNXthykwjkon+VbhJ
 4FOg==
X-Forwarded-Encrypted: i=1;
 AL+hErEknHUIziEC7QCHXmnYLD8XC/xvVyW67lH0raO5SpS+mBuy9vmZfZwK49hf/t6JF33VtKBRVpPXhd4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8JBU4v3AYXX4eh9eYXbO+CY9tHaIkVF8i7HiQ4DW+S0cvYZ0Df
 7IzhiB23EiebvRP3AX7DLO30Z1PTLfF2F/gbvppRw9KazUU4Lxi7r2N4etTbyH8P1V1Oz7pyCtw
 DUx6yaGOypUbvH3jx2PkpMV+mU3zSlxA=
X-Gm-Gg: AZFdTZfSyISxnsUGSFSCIzxMuHBNY+QS8WNCLQCk9C6j5Hg6TnfUtj8To9MADDVMrbG
 q1aooQVZFl1b/WrMZwVF9p9zJrJfAarlo/AVPh2AgkUwiAJ3a7/5+q6MgyANEk35v0GFSQx4AU3
 tazNlT0DaGjPEj7oU0H4dnOI7xgTbWgewB1ztIZ7fghgvtZ3SK+IdJyOyaVnXRsmnpfqUHQcB+Z
 AOyuWBpDU3IM8W84C2bmjkFejzD4KZa3fyui/XfmDpvLujlarE4WP/cnmAEYGzZrFgnMA71a23P
 fANUL4hfYYoVrbayv1wbGEP6VB9TDDXKxAltt+AWNoj81vfP8fBkR3AiD+Ta8nOklxw/5B9hv6f
 tDoN9MYRhEL73q7iZi/K0IcLSlx79ucSI+JZxnGwZ6WaDPI32kFq2sUgBfWwA0BPMNFN3RzOot8
 NOsZdhW++NA5o9zeD/qkJeLDcrR7s=
X-Received: by 2002:a17:90a:e7d0:b0:3ac:929e:691 with SMTP id
 98e67ed59e1d1-3b41c8d5a52mr19433019a91.17.1795701172110; Thu, 26 Nov 2026
 05:52:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6a10:6e2c:b0:75b:7b9f:2121 with HTTP; Thu, 26 Nov 2026
 05:52:50 -0800 (PST)
In-Reply-To: <20261125-crosshatch-panel-v4-9-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
 <20261125-crosshatch-panel-v4-9-120adc58e737@ixit.cz>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 26 Nov 2026 14:52:50 +0100
X-Gm-Features: Aa3M54oHeb3oomwOIo4taV5C5Hfv0oBSmEs4Eru2p6rZTVuSyDwStLlExcw0kfg
Message-ID: <CAB1t1CzK-7oW9qDt-hSk6AWW5813smbBOSXivWRtqur4Pzc89Q@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] arm64: dts: qcom: sdm845-google-crosshatch: Add
 display panel
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
 "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="0000000000007c893f06612e42f5"
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

--0000000000007c893f06612e42f5
Content-Type: text/plain; charset="UTF-8"

Hi David, all,

not a device tree expert, but LGTM.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Petr

--0000000000007c893f06612e42f5
Content-Type: text/html; charset="UTF-8"

<div>Hi David, all,</div><div><br></div><div>not a device tree expert, but LGTM.</div><div><br></div><div>Reviewed-by: Petr Vorel &lt;<a href="mailto:petr.vorel@gmail.com">petr.vorel@gmail.com</a>&gt;<br><br></div><div>Petr</div>

--0000000000007c893f06612e42f5--
