Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE4606A330
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZopJyU9w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E49112823;
	Fri, 27 Nov 2026 08:29:11 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AA610E332
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:41:55 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2f0213202fdso37352415ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 05:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795700515; cv=none;
 d=google.com; s=arc-20260327;
 b=Tdo0NxiTLeznRoXR9jkRCq+53rN9N+OiOcvxxPoobuKUK4AHD06OwRuzquCzRfdZHt
 tY0Hvr/jWgVpr6wtnhZG9DTXlJ5z8aQKig+qFOauyhtKMYdskU+rE1riZMe/8ll1UAaV
 IBGO53pyyvkZtAGy1yhWBW3CAUd1gWG+vu5de/26xCAXwG5eZAuuoiXnoJ/TRqN1pH6O
 Xj5JZeefJaT4LPc+PTAlzGGTBm6YEdCXk8fWOqrpIgaY9Him9f6qN6OkkAP9uKLLXqLc
 RXWPatUxdfO4vNAFUFsN434mTjpeqh547jDZTvW5btKmmUD5cD0gUvzHrBCBHGe+f4k2
 kNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=UAKWyUTCh18gL2baHT4lEyhfHbCGOXBpLR6kj31mINU=;
 fh=allr2Homh5dvVJOl3kOCNN8VPEvp2T1aeECyeirKLGU=;
 b=N7rJBhejZmFHZrpO8DK8I/8BZ4FL2k2qdDaMm4QmP2mpnGf9InWLC+TNTEoydPd7yZ
 +6bjQfnfyxIkebjJiTt1hb1ogPnMSANWsbCptnIrll8it6ovJWM1VSGMDhnvVnN+6dLV
 qnqdlD6sah5uZXb2GMwzbUGIaEpoRKUlgiVN4Z2EBE8Tw5JA5FOmOg4f7rJ6T68Uk185
 R40Mrr//33SVIyDvL8XKcaxiuewdN1OgFQFTKZVmZrLtAY/V2OZblbM9W9Ihy7a06jY5
 RQNeEJOWzEgU0XNO/DTS0SH8rWeFt1396zeHiVm4Hfj17MfhsDOpgP6opUK16zx31ZEr
 NMQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795700515; x=1796305315; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UAKWyUTCh18gL2baHT4lEyhfHbCGOXBpLR6kj31mINU=;
 b=ZopJyU9wEd6pzwUGwQ3llbFronR85guT82qjVFnnxdCUeboBYtYpklJBjlI8D7X5td
 VKGmw9uDh8yXeHzU7LviSJuMZg/kfC5NXHBMTPxXmtBv2bmxKqrb7PjIFOwHDJy/DYdC
 +fvcTAUeehqdFtx0qI+mIkOhnywLTg8Bl3/fCngTihWGerrZS8uctFb88K448ct8WtsJ
 yYFzs6/mlrITixC9MyggywGEQbP5WfRZUjeWr6lgEyfxg9eFYHKgqvcIjp8a2MIs178G
 Mi0FwOQafSYnL7NrKPr0j8Zk5Q6zQQ1eHjaS8MiSfGYsLLQpI+Lj9J3jQdEzFsoz8HsP
 gSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795700515; x=1796305315;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UAKWyUTCh18gL2baHT4lEyhfHbCGOXBpLR6kj31mINU=;
 b=bORBLUalXUq8m8USHvhNTxiXU5W2/d6UllPrULUB6GpxNBSigXTrI9Xpv/AEDall1l
 wiP7XenCQ0yDwRLgWlBD348QfLMqemcBneXidILVDHxC8ws+cmLSC9h5U6a7axajFMWE
 lFj0nr/zUHac+tL1+PmZhKJVVnS5cQ9nhDo6OnQaRIixEERt9/JYOi2p3LeXrSfTXzrM
 63EekrvtAe6eX6R6TG14SnR6Kzlwg/HCIo+nsMdXsxeyeXlY0cdMpRWwvzkJeaFX+6j8
 t2NYdtlvrRXjRqYWHfOUhxee/gApnz+ylT3ic5pGzzRgWAhV4Aalcsj3UMpk6fXca5et
 xR/A==
X-Forwarded-Encrypted: i=1;
 AL+hErH8UpCe/qRy9TCVcHTFxE8oWbvpMYTPurExfTQ1GIjX9M5S3rFuVFG7+qg4F5m6VOeaASozC664ngs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80rwaxKCWk/0KEFTRR9eE8m1qSzAJAogQhgbbO0Vsa4xzhMViW
 y+DoOYglYN5agBgDhEPGB+a/sBQqATGdQXoCzzh6wMMz8DUjCP+qgBCw36zbAnqjq627aIZaI8T
 NMoxi4mApVvt9q5Cv/Kb6MtbWd1KUa2E=
X-Gm-Gg: AZFdTZcz/fAj38MWZ3wzzWBNoQ2UCBwWZuj7/qXWSE+IcEGFNooAnLJm2X4I+jMlFJG
 rhwPEnSOuq+Q4/DBDVzPRJH46jqck8c8PLVFukDWh1yYbDWjxjEk2rSYStvJIEPcJu6l4d/mPq2
 mYa/puaiEfF8scZVmqEeY/xe16P0CX3q2TFIscqRk1Am3fdBbbuSSUUBFjn322aRNtqOmGPfUk9
 RtU2vGee+q1288Od2+ckcevPbBo7kTJwU5It1RYt7rlRDWe3Z/pi2wR/gAIBYHE6IwuDkgoZOrZ
 8THaDWB64E1xX/cqydXGJx25AtajwN4Ya74AtPndCB7/m2iHyKrNpDiOjZtKbg8+d4VDTQPloaj
 1vHUOhLIC/RNQ61SFOvLyq0h+XfRBJEHSBXLnLqJPi9Eyi283dnqLJ2J+MemPYAGQ9dh8IcZDC3
 Rkqa9cubXftc3oG2Q9T3ZQE7/5SZU=
X-Received: by 2002:a17:90a:c10e:b0:3ac:9669:846e with SMTP id
 98e67ed59e1d1-3b41c906b8emr20520461a91.27.1795700514947; Thu, 26 Nov 2026
 05:41:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6a10:d03:b0:789:8b96:6e82 with HTTP; Thu, 26 Nov 2026
 05:41:53 -0800 (PST)
In-Reply-To: <20261125-crosshatch-panel-v4-2-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
 <20261125-crosshatch-panel-v4-2-120adc58e737@ixit.cz>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 26 Nov 2026 14:41:53 +0100
X-Gm-Features: Aa3M54pBGhZ1XWb9_Xp9KgYLR4Vuj45rbqoPPBZ5WxzAve_vCSagOaHvtAIfFTw
Message-ID: <CAB1t1CwcbkNLh4FY5RqTqBBi+uRN7C0bXGSpjp0Jvx-jm3zQgw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] dt-bindings: display: panel: s6e3ha8: Add
 AMB630QY01 panel
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
Content-Type: multipart/alternative; boundary="0000000000005107e306612e1b44"
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

--0000000000005107e306612e1b44
Content-Type: text/plain; charset="UTF-8"

Hi David, all,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Petr

--0000000000005107e306612e1b44
Content-Type: text/html; charset="UTF-8"

<div>Hi David, all,</div><div><br></div><div>Reviewed-by: Petr Vorel &lt;<a href="mailto:petr.vorel@gmail.com">petr.vorel@gmail.com</a>&gt;<br><br></div><div>Petr</div>

--0000000000005107e306612e1b44--
