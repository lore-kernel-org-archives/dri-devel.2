Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F2606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GDc+/vb6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3196410E395;
	Sun, 22 Nov 2026 11:21:33 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 934A110E395
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 11:21:27 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-3adfb744fa6so1988131fa.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 03:21:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795346485; cv=none;
 d=google.com; s=arc-20260327;
 b=OQiZjwgqZtxVDmfyzeMWK1TSJxIK2+1UAC0stfTcn/boWycPLKC3Km4Sq/Fnhlclkx
 2dpcfZlHKgIxbxJjV/fQikIpSHW0H9ucsQFuYs9eqZR7g6BIBSwES+0kexnIvFKlZS+f
 VRts9I8pjGezwBof73qYx15poLcxiHEy+o+YOE/6t/qaGgGwJVDFozZLCcrnJIj/9cMS
 WI34vfkrQiJLCQHUrzxw828qBIHViIWnxwuayCjT5nM2a2wgE/6D7DL99jWuNvfNw4BU
 ZFhfoQY0K813PzDtb0HCCRT7MoKMUhjE6rZI6Ps2nlkTqr9OeOiKOaFTe6mUgucWb0Hd
 L9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BCdFGEAGi1FkXvjngBIPRRqSI+mSTpjGWxSdX4AZ69g=;
 fh=YwW1rErXLhIVbqG7OPnTViEEDy6L9NCZ64QSkkFyzws=;
 b=okJn5VgADZE34ABqET77e07tNmk4/83be46XwoKjJLKCUAHwVH0RMcJE+p0H5qvC7s
 rULXjIGbdMJ0SiikV9TRjFYCmJ9YzIXQWt2ia7b4W0Tmg9wABWgXWP7Vn/9OhTBHeRyI
 MEG7lZdrCvB3Z2ko8szDHqFZiKEnrSE0O4go4gzU52cK6gYNSSLx7NbX6RvFZqmlCcHL
 hzy/9KmmrSbbhZoOSUeqsaizWfZrmxiKRoEVgASfL4WPEhMhVhJeqspgOMSpk+z41G00
 517mCnoYvO9gjd8ir4eU5ANlUyZOkFbLvvOip2e6cOQoE0xDf5y2/1YSJN48NcceD2PG
 9wxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795346485; x=1795951285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BCdFGEAGi1FkXvjngBIPRRqSI+mSTpjGWxSdX4AZ69g=;
 b=GDc+/vb6FU8ya0TsJJmbTqI1XKBtsnI9gKQP1S7sXTdwtlksJkjgdvHQGAzPNFZ4or
 +AB07Uo50nikijHHmQk2G8dkO15KrY/iHcr/SoOe0Y8Fmd+KheryfylnI+VUMXjIggfu
 oNnFWu2VItKRbjBn5qsmoeRpXiX5D1UZxPSvqx52XoMRaXzgQpVESAs0GnIKXLiszALM
 3gkn2Emm6MYqb0fx7gEFrUWjPCtdGKIs750uACTWNd243jXO1ZKvTsA8L7/qPy7mdpEP
 y941rdFK/rHYwWl+SwrKQ5IIp+RTy7WUw5V+KaOA+0w9wL/+r6txdLwWy9hN3LnVhf/5
 nasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795346485; x=1795951285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BCdFGEAGi1FkXvjngBIPRRqSI+mSTpjGWxSdX4AZ69g=;
 b=vM7pWpVN91HWIjnd2VJ/UWzKkW5cQvetJvDpwuZkCgk4CgJh2nT6ZC8j1Fk6K5aRoA
 j+8f79boMm40btUxlAhFSorDomG5YLbhPKOuGVnNz0YpNnVXU5N7SutdzVZAIOwQwuZL
 vtBEbIRKxwm9fA/e1hZMqZ5VZXHJj7Dd1zqBNaFdoq7cC9GfS/iWzyRp7Nw3KqFSSSdt
 eS3Hchh0x10sKvu8iS8S02an1qXnmtHeFHdYg3Zs5vzRnTIOqmcLdxmmVt7L1sbRFsC8
 B/bigyVvea2eP/adU8uGyW4SMtmushAwnOIIIJy5pVqCM1Q1FvF1LbgpMrCtX/tJv5Eh
 yfjw==
X-Forwarded-Encrypted: i=1;
 AL+hErGO5Mcbh0BSHhNDaLJT3mH9hDqstK/xj3i9TtraD5kIwDLmm3YZu0ncteIlQ1PjIPDrwJhmCNU5JkU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9oPTZv2ojSTFa1noHCaEhblqAUMOvx06Uv6/AnQst8ebjoH2jv
 knaSsQAUgRTTjQzeffJqfs5x1gTVYF0hp+jC4YCBqfBKZ0zwej/vu68RCdbIgirTwnB3g1y4YtR
 MonHK4f5XwxorFc/KbqI8TFOOyzYyszY=
X-Gm-Gg: AZFdTZeTu9NjUydv0nAL8gZvf0SRSDDKHM3XJfqEqneDLky6bf7bxds2/fPmLlLGHSS
 6YFz1Uj2xOkwFhdV1uj23Iwzmw7rfIk8sFzHgb2YCUP2++kRpFXugLEjRK3l+zJyan3+zQaBmHM
 5r8AMJTofsf1JzroZ3RVpSkkjS80jNDGuqU1aY7VRXq9f9q9BIVrxjXJLcCRKRbNzVGJ3Re77tl
 BocRp+HsMCYiyplCHduc8WxRzCdDNfk2PDk0p/SaOkqFJCwnopZlBcRPh/sWCbNiqKHehy9XP09
 8iV8Hff+lZvgy+jHX5x3zTw6c3J0AUm5vMqOWefd0jGQyAxQGfi6ZR/bdUkwmI7rIWn39A2MsLj
 rvD3zZKvpwegO0m/7nN536UR17aZuaJPm5rHU5Q1djoyBamCqW3LH7c8mm4Q27O3s8gdcH/TWc1
 db2yxGXzIP/7SLFXysMkc2rvyUV3MxnziUPS0nV38Kb/0xLLYhV7K8QO55MpDLjznn9mxou+BE6
 zEjrww5G06UCM+lmVf4UIqXW58dTWqankJTxdTEQYHHedi7ekuJW3Tnx8+LYbSOWyYVBo8v
X-Received: by 2002:a05:6512:31c3:b0:5bf:e6a1:3115 with SMTP id
 2adb3069b0e04-5c1bc76a33fmr3359356e87.2.1795346484987; Sun, 22 Nov 2026
 03:21:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
 <20261121141830.171033-1-aliceryhl@google.com>
In-Reply-To: <20261121141830.171033-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 22 Nov 2026 12:21:12 +0100
X-Gm-Features: Aa3M54oNJa8cPl_YiVnZHC_82X9FGjy0ARvybs1hSE8ttDDvbfY_eIi5LF9yt98
Message-ID: <CANiq72n4CLJZ0aZwHJYSnnc58haG05si6+ocibzd07HLgFbAkg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] drm/tyr: allow mismatched buffers for dev_query
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 3:18=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Miguel, are you ok with me taking these uaccess changes through drm-rust-=
next?

Sure:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

A couple notes:

  - rust: uaccess: add UserSliceWriter::clear(): Newline before `//
SAFETY` comment? I am actually not sure why the newlines are placed
like that -- if one wants to compress the code, then I would place the
early exit `if`s adjacent to the variables they check, saving 2 lines:

      let len =3D self.length;
      if len =3D=3D 0 {
          return Ok(());
      }

      // SAFETY: `clear_user` checks the userspace address and range and ha=
ndles
      // faults when accessing userspace memory
      let res =3D unsafe { bindings::clear_user(self.ptr.as_mut_ptr(), len)=
 };
      if res !=3D 0 {
          return Err(EFAULT);
      }

  - rust: uaccess: add method to get UserPtr from u64: Intra-doc link
on `UserPtr`, and span and intra-doc link on `u64`.

  - drm/tyr: allow userspace buffers to be mismatched: `set_uobj` has
a bunch of comments, should they be documentation even if private?

Thanks!

Cheers,
Miguel
