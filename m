Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D7606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GT38w6cD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 253DD10F2DB;
	Tue, 20 Oct 2026 07:36:26 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A2410E825
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:07:05 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a06ca6e8f4so365965b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 01:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792397225; cv=none;
 d=google.com; s=arc-20260327;
 b=Hqz7+p32sbDns3n5bX9MXOYKneWiRNiZy7WcrgNa3tRgFAw1Otw5tJ6fzWDm38kSC3
 4pS6NvnOWxN5Tiql6FV6moX2sWXEIKNsQCAKs0B7dM7DqfhkI9IDGTfyHTKDMknGxrBL
 WtlvCeWf6ws2jYLuaZ58tJi7cma0mhqkTPyy52PGaxSBlet17MhRag9wcFJg3pZvU8xt
 6ymkU2WlFv3mxV4ANAlTfQXGRz14R4h6y1aWG4N4Evz2TdgTIB0VwA1f1NmH0D2k0aus
 Kq2Z4PHhZI3xsGpHrOxs6HOoY/xVfUI45Aii/JYgluZAR3wGZJTvuZY5x0GtvPYDXCzs
 5laQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OapHBRcO/exbGoTSwjHoSV037nGR79dQye9OkHt9RRs=;
 fh=7xBZbsWuwRbwEKkh+3vFScqVf9peYwDjy7jOYQZ6kMM=;
 b=MXc1su33QR0aCQW+SLp58npytcyUS7dAqui5ptjUrTuR4QYJWYxk9Cuj8CwMkvUHQb
 Bya86h/Nj7v0m3p5EoagaDIAIdXRBcBIcw7dqheTLvuFrxvnEo1lrT95gINuihlkbyCC
 Ee6wXGn6suLWsQ/4lyv0fXTw/7zndiTDBzHG1q7LaUjpbMDDYgWvCk8qYWw3aGI6EQQE
 2bQ5KEkHv5dOtZrldAt4FmLiaUfDnUmVIWkxNUubfwYrqEEB8UJqbDvRa35ED0Xyv679
 ebvGOZmgNVSMsJUyjz+Ylwk/xQRXNq1oTlDUY0K0ae0Qeu5N4WCEgf1CM36XgN0LugC4
 ZYPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792397225; x=1793002025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OapHBRcO/exbGoTSwjHoSV037nGR79dQye9OkHt9RRs=;
 b=GT38w6cDZxWReyYRWZV2XtUGzgQfDZq+ZpW2eoHDytNL2ud7F3aNQPQLhziVVv5uBv
 vBjB9NU9CaKAGGa1XmGKQ+dEBayTlc4VeGg3bFqSOYTqu6MDUbTfYEpqgtd3JCAxS2Wh
 P4IyHPFLi8ZTJe+rbL3Q2E1Z4J16R5kJFroyzxliYPQorW4OSjHEstEJCDUBvPnUWDc6
 NxUIDxlEbdeTSGpP1q8Vbtx9sc099dxal7fvg+9DbI6o55iaJu3w/AFEfbCHBSwW0DOb
 LA9TiiWhYMhBtxs+K+QsmcultccXF/iXZWBY2v7UafaSjZArqXMf99nNzs6HzkMczCxt
 6YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792397225; x=1793002025;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OapHBRcO/exbGoTSwjHoSV037nGR79dQye9OkHt9RRs=;
 b=1PBwrXp+4QJM6ZBwlM8+iQVeuCqx3wmE0Uv14Gu7A7lwA/qPLsevKIvhp519slGZE1
 NxWcIgZMQfGUIa2UmeBnY9XbZIK6/CuJLtJqsBqpI9OvTmdmCHt1zWPQtqKo65Jse0wj
 naz8IhnSLqNMeaXm3iukPKDQ8J+TmxYoXJh1iAIUECiEd7Ta25wao5DzybAAuTx89pKA
 V4bSl0xZ+hK4KYhlkn95UBZOX/NdZwQm0n1eHT1pEfCOi20arMdYtP9zkUckKErihm+3
 iVJ2qCUWIPZW1L3DyptRNbd8Y9rjaYsIkbOHTeVhvAZcvgm3/7iAHQuW8JPhmqaf0QqM
 FTbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2A+h+tSR2Bla/iAGSudAEmPL9urZWEJojEznOTHJ6XKlKRXvnNhmhwT7M4X4YjASGUb8/bHVUYjw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJRLjNlp8rnoXEOZQlJKBBVnmSTnHaylj8/dwgLOsTMGhmOa4kS
 ZfKjyII7U857nuCMcSXbgLJ7IxxB9/nNR3jRGW2QtX4yep1yhqE4Utsk/j0XGOj/1ph5L3jywI5
 rQZBJHBEXtkeHf63lA1xCoQkDH8fecNY=
X-Gm-Gg: AYBFou1/Paba1McY87k+oxqLKT2oFBXwAJnmVcrjtY69mn/meCFpffxhawcc6YtLgTR
 KhkiFQ1zFSnaAYEcDbrKlffWrj4B5xgL5nyNhucSa6o7MIuU5HNf4z1Bawcx8yz22N87Kx6tclk
 J7haLsil22ggFZN3Gec5Njx28wAIKgSf88TsNtQOswO13Y6lnYdumQgS3qI1xFzXSrDKcsSexRd
 czBgyTV1c1GpT6PaHMtDuoljVul4au3QST9qpLsfGgy0IkMJqAB66hGudOxz2nPHyqelpqtM57Q
 EHjYKHwFVaA2cy3hazp1/bCl+nWSQjEEiQxdqbvPji32mg8c7bGrEybYDL8+OT+3owcTUFJM71l
 hJS1PIuBUylRHm+RGsCDUDtZHYHNXVcicrBXJ5Z26TW9VYov5GncaoORtFbR4gsD3wl7jqMogIx
 LE311kvw==
X-Received: by 2002:a05:6a00:1f12:b0:880:973d:597a with SMTP id
 d2e1a72fcca58-8a04d04e513mr5511453b3a.53.1792397224811; Mon, 19 Oct 2026
 01:07:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-6-lukapanio@gmail.com>
 <20261019-free-groovy-grebe-7e50d3@quoll>
In-Reply-To: <20261019-free-groovy-grebe-7e50d3@quoll>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 10:06:53 +0200
X-Gm-Features: AclHuK9kTiQI2FRvtYDoJKATe8CTCBUQkubjvei0NZuQDDdDmbhaB9xhCb4qNvE
Message-ID: <CACi=Ov7D503Ug-D2xmKvRP-LceQpEWOrktXTy5Srdc-MZO=02Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT8722
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Henrik Rydberg <rydberg@bitmath.org>, Douglas Anderson <dianders@chromium.org>,
 linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,


The FT8722 is a TDDI: a single chip that includes both display AND
touchscreen controllers.
But seems like other  cases like this handle it differently:
focaltech,ft8719 is the touch side, while the display side is
documented as ebbg,ft8719. I=E2=80=99ll follow that in v2 and use
focaltech,ft8722 for the touch controller, with the display getting a
compatible for the panel module including panel manufacturer name, or
something like that.

Agreed on the properties as well. The supplies are shared with the
display and described on the panel node, and there is no wake GPIO, so
v2 will disallow vcc-supply, iovcc-supply and wake-gpios for the
FT8722 and keep reset-gpios required.
