Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A073C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D85D10EF63;
	Wed,  5 Aug 2026 17:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ltYOFZgF";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D7610EF63
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 17:21:00 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cc8311c6ddso1672305ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 10:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950460; cv=none;
 d=google.com; s=arc-20260327;
 b=PqsbqDujhdz5CT5FUqOcOoFK7Oj5rVrRWfa9/wFxqu0+N7uhrIawTP3k0ulas3fXWi
 BsY8K190V6NA24mykOzSDMDULQcdxAr11DEqv9vmo9th7cDkCoQIWJsfE2rP+ziWlPIC
 nrQ0LkZIGdcjrIgHQmJX0cL5SBtrGewJIUsryr87ynnLFfrJZ2fid5/cA8GGB1OH33no
 KQgc9x5c570CN0wlWBPC5Mp/oHYYzzEx7vAke/OqsYQajfkxtpo6l5Pn3vUGnAf4H6I7
 uI2LT0Vdp5GqpSEcqUCpesgusyNzdTrPMuWe4bXYHnhz9zrgsqONzAMISNK9+zy4X9hH
 sB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
 fh=e5DbOG/YqwIeyjj93Ejomc0Ej9PloV1aJfqUXaiyBos=;
 b=fLfTxUGJKfW5jSpZ/L0+aAPrKgQghgZapWMjEhXuDwYmMret3YaYF6HyrVKWnBiDHm
 wExb78XEdYwH/escTCzn9taK4UyP3wm99Yc+zhCvnQxaOVw/xNbRECIHLUKTu4FvgIRa
 LaYmKnYU39OYOPz3sql3vTXZzDXg2lyrJf0WGmSS2drw9Hy650Sq4tvV2RA18/DbVAR0
 D5WJEnT06jnbzp8PWEBK3BCXASWILU1GrImFJ300AgVdflBayr3xvJuwqsSp74A9jTDB
 zG8HYeFwgLPATxgWz6YDNqRHTqCuv1dfu0klguZAkDnL66qkkSfKhdAGUSvYTFHFbmXX
 ScAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950460; x=1786555260; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
 b=ltYOFZgF1F1Ux1hvtxfhpCkY+Dcl8KP7mwzmAmEnG02sT7ury6FQVVCova/sLj0Ulv
 lzVYTYfjSUu8H05NKEh/jIeUKCgrj/16CkY+TJds041g2pK0BNzUNzXtZtZxWw29HwRM
 46Le+9kF4g0SxZXQ2U09sE7IF1b/qsqyyiUWBC6A/JAEv6g/7/+oABTE6Yo8KJRgKpz6
 SkHHz4d0m6LLz995IvD9gM7Z0rux8f4qdYBPITjFvSsW122UwXclBJYCiC0XR6wzhuSJ
 W9MpJWc7gG3RaITypy2LlcxRGbn/GK5cmXNVFGxDDCuOQGiXj5LKd5JISzrN+MT2cWmD
 R1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950460; x=1786555260;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
 b=J276DXJ03FRA+wm+DoFfCuSUH6KXzOu2DuNvfV11lheU7vGVuePjuZIeseJrZf8qA1
 jivjYDgEsM24l1O5TYHroCZ8TjHth99T78gzhhnBQF43l6v8XfMbCZft0hll60Mie8cD
 8Y9KGmxFlIxIAdXRrPWn3JKfHCZlJurhZXkyJYkmZWDH9EnWgavOBkAGoO/RrwWNjwS8
 vlNwd1lWWEGMfup8NLCW1MTaYoYRX0VhnlQB9pV6zpAS7BSn/xmAl2XqetNVfkqAXD1l
 LWOyk8CQAgKIC8s7qWfhYFR+M3RhqkC9DDykjowVzbVUF8bJ3nAsM6PRwb3l0ptDietN
 40Ww==
X-Forwarded-Encrypted: i=1;
 AHgh+RqA27Zx9oxALe5C3Od5Fun4DY9o4o3nAIMPhMNU13AJLPqUlrB2CLbaJ4tkK3YxGu65+gbrmeIWC90=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlYn8FQXjtf94XpZHCnXb1hyMSqSAXOZHU6O9q+TzG1y4/cbIi
 irexwBcLsMGy1EGqkha4qyQ327mm6ffmIEjGtsVm7Pm+sp71b1H+9ms9iiSyIWEz42xtkvW0SR7
 CM8Z1N7fNLSg6kEt6UCq+UzfRTz7Q+yg=
X-Gm-Gg: AR+sD11sxAYcUoNC2R1JAKKbxg+OKv6SgNrKH+JjJDNBP6wxs3V0lzwbOcJO693g75Y
 Z675Y7Mx+QpcRRIpwugZbMyQ4yC0g28OMKVjlKf0Eo61q7s0+TcqFayJSoBWpA9t59ZLI8tgS9P
 Jateru3Inz01fZ0aWZhOielICDlWQPhOcBYL740j/NnsH4a/yNqk4mqht2+N/ptrf4NtaE12emS
 GBl1ZDHs8nwp+XXrHsvoXY3rcUUn1HjnjVmKc/N1SJF/1lqe53CLdvXsTDTC6DRpCN+f07cEwcM
 7hxzY1CJboNs7+Iq2PAiN7cH5EEs6YswlvLo+VwUWm0Mytikq3Z92S+UbpOVs2ujEAAzf55JnWF
 jFibmZk3+1DVLU7gLMFQnwNH1hrfCcXO5mMIqPwLKrdeRgwfFOgu6ULRFYSvP
X-Received: by 2002:a17:902:ec8a:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d0ca1658f2mr73522915ad.0.1785950460122; Wed, 05 Aug 2026
 10:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <0CoR7Z5B4-PH8GYYbWlZysVJpMnNLTFzTO0tBlOpJQNFiQ2CPrhdjyD4-4jQs4n0J_1QqovCd_EaYpclyigEKw==@protonmail.internalid>
 <20260628095132.47753-1-trev@trevrosa.dev>
 <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Aug 2026 19:20:45 +0200
X-Gm-Features: AUfX_mwN2wRwvmcNPuq0EpEyS5qgayFtXbsdflDPhbgmFxUJf-YMOIqJTLTJEvs
Message-ID: <CANiq72=wo4LOfa3hrJhTFr8UzkchW4QQtUespCTq7qRJvrr6CA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org,
 rafael@kernel.org, 
 dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
 airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, 
 sboyd@kernel.org, m.wilczynski@samsung.com, boqun@kernel.org, 
 gary@garyguo.net, axboe@kernel.dk, daniel.almeida@collabora.com, 
 shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, lossin@kernel.org, 
 acourbot@nvidia.com, markus.probst@posteo.de, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, david.m.ertman@intel.com, iweiny@kernel.org, 
 leon@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
 tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, 
 ljs@kernel.org, liam@infradead.org, bhelgaas@google.com, 
 kwilczynski@kernel.org, ptikhomirov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 5, 2026 at 11:26=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

In case it helps, there was a v7 of this one:

  https://lore.kernel.org/rust-for-linux/20260628100731.64885-1-trev@trevro=
sa.dev/#r

Cheers,
Miguel
