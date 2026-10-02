Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805F5CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC87A10E572;
	Fri,  2 Oct 2026 10:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UsaPElRP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8FA10E572
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 10:44:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B16DD60A87;
 Fri,  2 Oct 2026 10:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755A91F00898;
 Fri,  2 Oct 2026 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790937851;
 bh=h7N9N0HQ+Zh/gY8vIC7G35LJ75G5/SbSrtWyyePbhUk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=UsaPElRPg/30Lnrhk4Ik3ymnfcyrOgc99vuVvDOLJXtYT3ZFZmtKEcJ5ntZTr4fi4
 ti4hkjw6BzSsQPBOVVVtH/ZGri4F8DMUUctmAJQVgGL1fpiqOL6Urwc4OKEliZ4eOZ
 7ISxv9n0Dd853wwyosUF9xU26eDcbSG13N7RYqY9e3xw15h6NElqJWm89NGKSPHPZF
 rToWFBqc7zwXWAMWh3ajKxaMAszweHynuyTf5jKRYNEzsp+l3Yicd1H4TF4FapPzVg
 0FO/fclE+/V7/m8hDXTxwA2WMimJKb3jco/s88KvWdXjUHSFrfm2r/XZSRaqno6VTc
 ioun6aWDg4WEA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfauth.ams.internal (Postfix) with ESMTP id E29DA198003A;
 Fri,  2 Oct 2026 06:44:07 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
 by ams-compute-02.internal (MEProxy); Fri, 02 Oct 2026 06:44:07 -0400
X-ME-Sender: <xms:84q_akNtFc_m8IqPCfS01lwOwwnlb6iwWNsSeaP5LZ8Jjrp2-u3vaQ>
 <xme:84q_alyLnBtn5FwbzjNapuvaHdpW6B-9vMFARV_dsiXL0fQeSzgwbddu0dCiSkc9Q
 8a2BM8XfbeYmeTnHApNqSlnH258O4q4an5JOkGoh9Bf2h4vXoUmWHXOXQ>
X-ME-Proxy-Cause: dmFkZTF7v0Xj1DEnpcO6BUVol6zWmZrAP6o7CWAwbHkhXdIDi5sSS7yp1xr9ZZPwIBhJBB
 GkXBQz9VF+JXcH7vt+0sFjJAGbofjSSmv/RNp/LtXy9wWYXx2hZ+b1RMskCVZPHKUMdb/m
 ZOatOHoCpXj0a+5ph5ldA1jKzb1ltDN2+7xxma8A6JrRxHKh638T16bFurO/dM3C7Lti8D
 l/JWE5GelKR6yNokvgG58ndMj85oi1Q3eGlSCRPSxw3CuPN09v6V+xYj8U2BkOzdi/fyBS
 Xeh6AuR5w7wBeoV114P0zZ9HmLX+orpjQGx0T/RZyJ/U+SYak5JNnunLMEXnRZNElXI3XV
 OmfKF7I5/l5lJnHfEL1ffIWJ6vZSfAFCrcfhH2R4hURERo3ZLyFgUBJy6AkKWfx5oahjhO
 kjKgD+tn6FMYK89N3OwEmM57+lmjU8qMO3A9WB7oNAkRwqmBeA0AGLLdfJqFVcdIYOYwDV
 eOzEY0V5ipQDOL6KuHdtjC2oOw5qfkEDmH14PvAQ1UL/G99OsCNlKojPtxe2MiYvhCEFXd
 ogosyg4Dsto/Hmajt8Kjzp/RXiqy1ufa5tQqCnEpscgFXTTte47mdqfwnxJ+2KgJLVZsNF
 M9zx7lZhfKryMkBBxV+1yQBZIpjjYmZmVW2IPzuUKeoMh4/QNIgBPgM2vR4A
X-ME-Proxy: <xmx:94q_ak_C4KXvsHtNobGGfNaogyMfAk7tajGtMizHpGLeRGI7KN3JPQ>
 <xmx:94q_aqL784SESyq09pYFL_dX5zdWPonTeW-K4xVghEmHPEnLG2wN2Q>
 <xmx:94q_ap9rnmPKD8H6SvD-Ar5lpL9lk22OtJkTznBkS8wPTWnTfhtGWA>
 <xmx:94q_amFF_UHjAHVfwQESOn13ThpYvSt5tGXuLALn_hdrm_xAzwHLAw>
 <xmx:94q_apMIXONDJhbdtCTvo8nI1N2KYDTGljkHYRXIG5A1aaccZY-RK2sY>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 99395F80090; Fri,  2 Oct 2026 06:44:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 12:43:43 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
 "Jani Nikula" <jani.nikula@linux.intel.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Francesco Valla" <francesco@valla.it>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 "Jocelyn Falempe" <jfalempe@redhat.com>, "Sam Ravnborg" <sam@ravnborg.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <9cf259a5-6083-433c-8544-ca3f6286334e@app.fastmail.com>
In-Reply-To: <CAEUXW=GKRstrsZniQSU0un6r--a2VrRjpZCe5meUyyxunJ-E7w@mail.gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
 <20261001195847.141192-3-maximpedraza@gmail.com>
 <5c92c6f27b0778124d2365603374f70bd9b69b8d@intel.com>
 <CAEUXW=GKRstrsZniQSU0un6r--a2VrRjpZCe5meUyyxunJ-E7w@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/13] efi: bgrt: export the BGRT table and image
 size
Content-Type: text/plain; charset=utf-8
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


On Fri, 2 Oct 2026, at 12:31, M=C3=A0xim Pedraza Padilla wrote:
> Hi Jani,
>
> On Fri, 02 Oct 2026, Jani Nikula wrote:
>> Data is not an interface.
>>
>> If these will be used more, perhaps it would be better to wrap access=
 to
>> them in functions? I think most of the time it will help with
>> maintenance.
>>
>> And you can add stubs for CONFIG_ACPI_BGRT=3Dn where they belong,
>> i.e. include/linux/efi-bgrt.h instead of drm_splash.c like in patch 11
>> of this series.
>
> Agreed, and the same goes for your comment on patch 3. For v5 I would
> replace the export with accessors in efi-bgrt.c, stubbed in
> efi-bgrt.h for CONFIG_ACPI_BGRT=3Dn:
>
>       bool efi_bgrt_has_image(void);
>       phys_addr_t efi_bgrt_image_address(void);
>       size_t efi_bgrt_image_size(void);
>       u8 efi_bgrt_status(void);
>       u32 efi_bgrt_image_offset_x(void);
>       u32 efi_bgrt_image_offset_y(void);
>
> The splash client then drops its own wrappers and stubs, and the
> "static inline" in drm_splash.c go as well.
>
> drivers/acpi/bgrt.c is the only other user of bgrt_tab and
> bgrt_image_size. I can move it to the accessors too, so that both
> variables become static, if that is wanted; otherwise they stay
> global for it and are no longer exported.
>
> Ard, this changes the patch you acked, so I will not carry your
> Acked-by unless the above works for you. Both variables become
> __ro_after_init either way, as you asked.
>

This sounds good to me - please cc me again on the result and
I'll take another look.

