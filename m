Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D591CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D1510E58A;
	Fri,  2 Oct 2026 09:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iO9+iAzp";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69AE10F80E
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:16:31 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a01b560392so10839705e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932590; x=1791537390; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Es1ESAl2Bi9P2/UjIit9xvYINnvS6VIXIVgcZvDxiCM=;
 b=iO9+iAzp7WPDRIC0Qmo7uEnFAlcaQ0jphBOSaaeKjCBUzicBWo9PWhZ4nN+SOLkud7
 s9li7P0bv1ZjEqIZ5v48H/yDkPBx42hyiLgvvIFcOidTvdLo9XJigjypaM9jLU5+d27E
 Z2LTPTXg2U/vjbznSXdJgVghoET5XKIEFoRTFKD9/33PUoltihukYiwa5cvWRn9zOWOK
 +rfsJOAje3s4ppUiXx0i3ObtbAM9zpZB0Vwc8G9xyuUhow3PFGMPlUFs2NR7RXULK4Nq
 ovd7LUspnM91oy5+iLZTMIrkhizEEbEdsdQEVBNtS9qbwuk6cLkBHzc4H2aH52Xm5+fH
 55SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932590; x=1791537390;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Es1ESAl2Bi9P2/UjIit9xvYINnvS6VIXIVgcZvDxiCM=;
 b=NdHOVBiApyTmiSJ3PnIG+qa2/+PfHL1G0UBjm7uDZQTQdfnkWTUiJW66FSgu6iPXs5
 1YiZXCFk8vIaxJ0do/6C94qPYTpH1z/uSQzLMiVyixBuK+cO3QVJtj5HUjJ43EwtsLkk
 Se4OJMlnMwZBjbcUgbK5TP01oYjQeM04OlgGgDy7KwolzhZB7LsFxb6LwnMYbZKCTiR2
 VY9iG6fBCah7F0vQ8E/4N/C/uoVFOQWFkHB03NZASd3v2H8+NzulhRB7TpEouZz+cy3z
 j+iLu5kGjIYHxmWRttntU+0tTpFzFESzBJCQjgJP93Apf4gSOa30nyRLB9uiwfF/149r
 R/ag==
X-Gm-Message-State: AFuF++lBqzNg0tcOFlwk5GerQ89V0V2Q/9Kw+llgyRd77rnF1DuwiASy
 8foL6XblsXBT+RNLnLgxyJV0CZB6NJJePeOvR67aG0FjP++KovLPX/6tU5yTgkpqxyo=
X-Gm-Gg: AYBFou1S0hfEzluUZ+lA17gw/tGCSJpg7Y6O/a7S1XoFRRsc20ZH7k/DWito1naeLDn
 31JT2OQABMPTfleV7XgWQKj/PuZeGsKYoyqsDkNz1e85jnGn7VzAaMDKbbFybN2pm/fbayY/Gyy
 sFRUsOh7tY4ziMWBdPsa9XSGhmAIq5sRu032Cg3TzcAmW2+a57WBz+iHqaTlIUXXCWlsR4Bbj+h
 6rZcyJvN0FbbtJfZP9sHrAD3gxtaLaZuRp0ZVC8s69UVaCoC/Scl1DbvPHWoR6cxwivZiowUPhZ
 4mqj7IFUrthwA22VZ+aBw3l4nDuwxwoYC5+0yAFJRq7AcRPDtTntXiDd6ahtdOvpo8mUQgFJ/kd
 9huTTB8l3Dc+jwXT8jYKVhcKckyI7eUumob0MuQFFEmr3tKs8eIv4PlUoD4WvORvM0rz5o/TLKL
 49bPEkLIr45tFAAeXFfSYVQqIq6mwpkp+kd7moiEnlKHjo75Ezhtmavx/VEoSnW93MtaCoSS7uy
 QZvH3tHETsODuS42ZQ=
X-Received: by 2002:a05:600c:5888:b0:49f:d742:97ea with SMTP id
 5b1f17b1804b1-4a01eab3237mr86257095e9.0.1790932589833; 
 Fri, 02 Oct 2026 02:16:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:16:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261001-asteroids-panel-support-v4-1-fb228194ad91@pm.me>
References: <20261001-asteroids-panel-support-v4-1-fb228194ad91@pm.me>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Document Raydium
 RM69220 DDIC
Message-Id: <179093258899.2282096.1855528319289622159.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Fri, 02 Oct 2026 01:51:41 +0000, Alexander Koskovich wrote:
> Document the Raydium RM69220 DDIC and the BOE BF068MWM-TD0 6.77"
> 1080x2392 AMOLED display panel used in the Nothing Phone (3a).

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Document Raydium RM69220 DDIC
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dfb7ce7880264ec69579db6c309c00f6c788256a

-- 
Neil

