Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7DBC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 14:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1188D10E0C9;
	Sat, 27 Jun 2026 14:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WHN7oZ+k";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A977D10E0C9
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 14:22:03 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30c5912314fso232556eec.2
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 07:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782570123; cv=none;
 d=google.com; s=arc-20260327;
 b=oEmqWUN0V/5b6ep1KcVAbRjfZtH98ojW5EkRXUTqk421btUiZEzxqYJKZgUUzSvgfT
 3790aKPkur0xEbKPIRMO+S/Ha/ueMdMb8xK05q7dMtXVsaHqRh2VV/q3JsF3HpnrM9IR
 eDVXHhU9qPUM5HRne8HTgv8D8bptTmx0Y5rqJ2VztMm4cjcqlaw9VP2puNqr9f6DWNjp
 9hUNwWgd65c/dljqARGmiCpo4IS8Nf0di2B4qttq9fn/3mczy4YiOwTxI4QOU1H7IaS4
 zV+VhtpDt6varmbGzHRSwmmY/Y1lvPx4OkIWq90cLY5cMoC1I+uH8ElLyNBeJvLzBlpb
 qHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dnhPY84nbVl3Rm52MamXsK8B6ygO2wlFwCT+T0hkkOs=;
 fh=9pg7npaFVZ8iMCZ23qIE6KfrJeGgmWbWRB4VvdnDQgM=;
 b=Kc19OCl/RV/20xLcy7rUC9oVbMjUQ+vZinUhr2DcNNPTVu6wsaKxKjxZIDniR+UaBy
 9sKkmkA4QGHE7xZh0LZ/osFGm5YgnVKC9UcqL/8d244+WFu3Evww5gAu6brBeb/W35Ac
 Q+3q5E1Rv1dxLpT4B2z1jXqdyIxyZVkcPL3yWjZ2lwNEiXOYk0lKkQ4ObQU4BQJPXjM7
 CsbZCUPy760NbO9yojcNPKjk4H2+MEOECzYiovwUgkY/5JZrgo9x/I7F5g8pZq0A9WrQ
 6Mp/oik7S7541M0Yf0scBGIXFKWPCMhJ/lUN+vpjDSSJ9bQH1VlyM5z0VEJYOF6j3bLh
 S4sQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782570123; x=1783174923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dnhPY84nbVl3Rm52MamXsK8B6ygO2wlFwCT+T0hkkOs=;
 b=WHN7oZ+kEypKeSyYk8Uuiu+Cd6d8CTLeETLQ8Eb6eUUuEvlosnb6Tjv9x2pbHcwUhe
 KWXS8GQE0Z5tXRv+98mzu/bos3aUAlh21h8M8Bd9xBdbzPA+O/P0qqCyRWDdbuFKOcxF
 oc2rZ3khNGIPOyhsXzrOsoumXZKo074URpXBw8mFBoMLXasX++pBRaKyUpN8Wxvd5VM9
 EN8AxvDwmY2YO5auE7jxfrS73QLfAoDFyJES6hIBpXY3t+/egyde/7d4azaAFUZABawz
 1ejHTx/XFJmyZxWHmweGyEyWhmlY37kbfNjcSHZnUYiikNcd2YBNNCXEPOtRs2K3LnRh
 F3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782570123; x=1783174923;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dnhPY84nbVl3Rm52MamXsK8B6ygO2wlFwCT+T0hkkOs=;
 b=BLi/8n7SnDDy61FeTVjWL4txhMvmFImrUkUlX7bntDOSGFALmLl20DJfU8xYZM0ZeW
 imQ1l7pCPL74CKnqfAUmii1BYVi7KDwlnC2eY4W1XgxEjAm9jhQOzYxSdNLV2zwclpCL
 9w9okWJnK8CFTD0ISc+jzm2V4/xNZnrrmznau+uv1jsqMEa3GOI76zS5H/NY76K1QoPB
 N6NYPzFy0ccFH/qamAtIxx4fEdM0mgbvI1CCFuqAeXA6/Rn8fP2IuhDE+gstCQ3Lwxi8
 jgubLhrOxjqhlLUyw3n9CyP7JGwVzFm8leGgDb+YgX+6SESEbY8b1oQnHDcuXyCN9ryZ
 wY0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoF2Ui620Nc676d8w256tf7AE5DnjMwg7abgC6T4j+cqRPoCvR3o8QJwkhF7rMY7QOgRY25ujit3oo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUkRsFZVf9lm+8eo4Pz2D42JP8R+WYoA3CANFMUEx1A1cTqqOd
 63Abdh2FpTxY6xj1maU7S+d38h09X8DcUrWIvyzdCXbBCG7MR/7Lj+0iaAlM++IXQT82DO4Z7C/
 5QWND6GG1mEYCDDA3HWVxkXtIWFCfXB8=
X-Gm-Gg: AfdE7cl0ku9LnbloAjs+Z/4iM/WsJyBw7cVynbul1Puku3SJPVK5NXOuTp02PJImST8
 MnnBXvVFRaelPudZIhO/XwAOKxMlVx0ZxcKflEvaNzJY08CNkyMBL/agehlV7CjdMq7RGGs56rS
 yn65mjDcwMIqd1/72YpbH4ykgIhWQGF4/ziOAg3HC1qce/rTtP1GvNxBWr76LLIfkWTgkwXM2jt
 /NHlBGaw7QxFxwA4mIj5jVmbcuRIdIhuQt9LxJXeiPfgNTAwx8xk1wQ4dTDDmxxKjMHt2mKbwnn
 LiW4nGHRu7hp++uzRBvlU4UROCDCT0OwsYfwVc093Q1uYlzRjXXERwxU28yDPH2wlE+UmSTiph7
 kbdUeJc2NkoBx
X-Received: by 2002:a05:7300:ec01:b0:30b:e157:2641 with SMTP id
 5a478bee46e88-30c84d6411amr4636635eec.6.1782570122681; Sat, 27 Jun 2026
 07:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-3-dakr@kernel.org>
 <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>
 <DJJVPW8H183T.1927SIBS40Z40@kernel.org>
In-Reply-To: <DJJVPW8H183T.1927SIBS40Z40@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jun 2026 16:21:50 +0200
X-Gm-Features: AVVi8CctSDh_S_EW23arFCE2Q437EiWrwvRaI2YwlTvVdF9BNVV6NJ35O27uGtM
Message-ID: <CANiq72nr6UD=W6oFsJQaGrSFCRqyWnY80=SyNR7u6=eVQ7ci=Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
 tmgross@umich.edu, acourbot@nvidia.com, ecourtney@nvidia.com, 
 m.wilczynski@samsung.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
 leon@kernel.org, daniel.almeida@collabora.com, bhelgaas@google.com, 
 kwilczynski@kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
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

On Sat, Jun 27, 2026 at 3:51=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> The only way this could silently break would be to use ForLt!(), but then=
 don't
> use the explicitly provided safe cast_ref() method, and instead open-code=
 it
> with an unsafe transmute() assuming covariance from ForLt!().

Yeah, that is the not-compile-error case I was considering.

i.e. I was trying to think if there could be an issue with the name
reuse, since it can always be a pitfall. For in-tree I agree it isn't
a problem. For out-of-tree users, given it is very new and it is
unlikely they had that case, I think it is also fine.

(But e.g. if it were something that had been there for a long time,
e.g. in an LTS already, then I would say it would have been better to
pick another name).

> I can add them on apply, or we leave them as good first issue, as you pre=
fer.

Up to you! I didn't want to add noise/nit work, but if it is fixed
already, then that is great.

[ I also saw some non-Markdown comments in the other commits, e.g.

    // Invariant ForLt types (e.g. containing a Mutex)

  in the sample. ]

Thanks!

Cheers,
Miguel
