Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474661076389
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D8410E221;
	Wed,  1 Apr 2026 17:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWUQ4/mD";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6279910E221
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 17:39:47 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso4975eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 10:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775065187; cv=none;
 d=google.com; s=arc-20240605;
 b=hLD0Az9kmJiJ2bDyvvDTzUFdhCdFtBOG0QNO/D9qrP7mU6DdZ97M/+tJc2bZx4D1Zi
 Lqschu9HNOS4NopSCi+j5boapRFRtX8I7GK2AlgNUX7R+7cGLKxZVqAiQTE8OPsakl66
 tUX1KYz7euqq15xD074a+AKok2rbs6cWDVwU9ltMAH3qRFQhy6bBy0Ud32j+jolmhYAS
 Y1Np//Y8mwQnKbB1DdA8MDkwHdmJLhs1xNOM1IY9Eb9WBNLUfoIkF+5V9dhwx7QvT8Wm
 cGSsjxAxnvQ6fhahOFfiVVMesZvf1UQM9dTFth/+xCUaGmStBZNj1FBiR3ojpwCj93tn
 Mjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jYUaVSUk5Sb3SOTuQeoUN5R4tL+13WiT/Hvm7LoUgnk=;
 fh=oNWSkpdE1GBVZTZ90obVKwEx9SuLiss1jvhxO6JDr+k=;
 b=WGe6lNZspQDkpHAewuWj/UbOuG5O7RDpzcuz+0nKR7R7dbggn1mR7aJsYmgcO6XqR/
 4TgKErSjyQN7Zn6+MCEBCM3N7KH+vI66d0n7gLeRMKMujDCsRnqMQzU27h8aCBm7Dtl0
 WY7eB4GmUXxd/s9s4nHxuG3cTxhmxkyOhetK8JZUV+F7lSRzIMtd2imG1atiLUW/pZjO
 BjANAlHjyGQ75Barr4E9gxMbMRL5bpsQZtvc9jKLXZRy1hdNnxUZdJvhy+rKmJ2QQeO8
 fSTxf2fqMsNc3xjBdQRM2KS37Lq2KxG11RkPN/+5Y8T8zV4LQd9jpIB4rXTrWsBPeYY9
 uJXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775065186; x=1775669986; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYUaVSUk5Sb3SOTuQeoUN5R4tL+13WiT/Hvm7LoUgnk=;
 b=hWUQ4/mDCNNpbFCn4bI5SYdjvD6naFeFDgjqLJPXbUHA3TlyQ1d6BK7gcqlFh37roA
 2MxtOwTxxuDn2++yzCPCQWxZAFPA/iY1IAWUyAMRBF2bn+SovsmZpdn4IRp5JXwehgL/
 WlnF/9Sae4cWG+OI5JJX3gYDgUUfDtqvfMsc1NjEbtg+AJfKTpIlsy7Ox3+TjQ+kJ6fg
 jFlcjgko8bNDQLDL+8xv5yaHSW2WAQHvyyEbVANhlhT1afzHJQ8/7EMK6y44DN5yF8sr
 52Zh5Xod26wN1Trug+MNOOERyFy/VV87Oz6cLyQbhXDzpRmWVFUpIy9RNsg2TABotTwD
 moPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775065187; x=1775669987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jYUaVSUk5Sb3SOTuQeoUN5R4tL+13WiT/Hvm7LoUgnk=;
 b=QiPC28IaS+dJEyt1DxguMwlo+9XqVCVEelfsLA6ZtxdZN5/vkexlLZ9DqFEX31XQAs
 AK8PQ0rbkkx2ZD3x7NEWUe7oi0TGTpUMgXPXl8sIsQzNqE4KFuDtvS9A805ZRTZHz05+
 UiJxe+COj1RPLleGBAPu+0G2gNhTmGaHkP6gGKRS4Rz2Zvs9l8ObeltNRw3C/Gtovwqv
 A3HSJ60CVSvi3YrYZ14M0ESfHlZbj5nhNUchtqTE4r0jLpC7H1HZeilAIbjBt+w6mvLg
 K6sdkKCJan+vk0MJEml+jOLbFchTa5Kkn6t3NgWj2na72oTZBpdAmsglBrcjaS9ezjzd
 0Jcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuAbkW57+x+eUnSEADii7XgvnjyOGek8Mka/ZjdOtxORVgtmeMk6SW0yFkfeKdieX3bAgBj7DkGqg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLspE9PuwM9EgZagTY8LhBTjXseoPu8M6zrklIDtsvnOsnEu3m
 GMgWCyxeq7Rzj1FX1+qOp5IB3L6EkkLO0awg28WeycyOLE1QVYOqSwcQqV2YkacjXVY9MLa475h
 OPgP3sakCxnooWzx5aiH2wW3Db6P9Oxs=
X-Gm-Gg: ATEYQzwgf1YcpEUHRsnHvTYOgeEQHyaW1iFVsggwEjOGjy5/rEOwrVNyjrIlvKBAlKI
 +s+bUVx1znXyesEtcN50YVIFOvn6tZyxhsaMlD4bZijr8w/e19/r7rOypRT1eIXu75yE36doNoZ
 O5uTKcANR5Dpku3dmlhDqmmcAsGkZfk6v9YuECqBzW9tm8oIaMZ0Y2xAa0tuNQW213Z3Kf2NyHu
 l4axuY4iwtPs2Npiywc53OVFMte0K1Bo5+cFTMfoOHJ8G3G3FNQyCDVt2ozvZD0ij2k27XD0wul
 VgFe4VSklBk4v3HSugjVOu6xZWZQBHpq3HtlN8Htmvq3wQM2gN2P9vWHbxl6Sp6evngoD+HAnaW
 e6qQfC/nhH60eJwW3rS/X9JmPrwMgsSS/gA==
X-Received: by 2002:a05:7301:4586:b0:2c7:2cac:8147 with SMTP id
 5a478bee46e88-2c932cb3abamr970192eec.5.1775065186457; Wed, 01 Apr 2026
 10:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-10-ojeda@kernel.org>
 <DHHVLQAOMLWB.3FHHSYKNM5TNP@garyguo.net>
In-Reply-To: <DHHVLQAOMLWB.3FHHSYKNM5TNP@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 19:39:33 +0200
X-Gm-Features: AQROBzBO7Aafw_pbzha_JEZl4Ht2QE7dpytXYa0WjnL8RQv-FxGnezpSMqEOLn0
Message-ID: <CANiq72kSYFiS6zN+VLs2URhAeHy8_-aEXki1pyR0qoj7jO-qSQ@mail.gmail.com>
Subject: Re: [PATCH 09/33] rust: kbuild: make `--remap-path-prefix` workaround
 conditional
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
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

On Wed, Apr 1, 2026 at 4:08=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Okay, I see what the comments mean now. Perhaps squash this to the previo=
us
> commit?

This one was mostly to ensure the workaround was not needed anymore,
i.e. it is more "optional" than the other.

In fact, we may want to just not have neither of the patches, i.e. we
could just remove the workaround given the timelines of the branches
-- please see my reply on the previous one on this.

Cheers,
Miguel
