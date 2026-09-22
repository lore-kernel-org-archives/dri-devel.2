Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBD6C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D588B10E2BB;
	Tue, 22 Sep 2026 19:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YQ6kksDO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9EDE10E2BB
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790104760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/N7wXk7BVSM3SAsyNtWbX2CBIRAf2KG5eLQuiIHE1x8=;
 b=YQ6kksDOWzipWRjOJadS0OHdNBavZBgNiZaeeD2250jEUVLUsE/bCTk9WiOEY75sHLrufv
 H25tabJGYZxwi3EvNGXibdx/i2ap9qWvluP0+/dnrI+R+YSgLTRkbr1WENlf91KorDtbog
 ia/nMNfvxM+ltu3ohrzI3htjL3GbBIY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-AG1RLoYQOQ-N2io8AGticA-1; Tue, 22 Sep 2026 15:19:18 -0400
X-MC-Unique: AG1RLoYQOQ-N2io8AGticA-1
X-Mimecast-MFC-AGG-ID: AG1RLoYQOQ-N2io8AGticA_1790104758
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-785827e6073so77054137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104758; x=1790709558;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/N7wXk7BVSM3SAsyNtWbX2CBIRAf2KG5eLQuiIHE1x8=;
 b=rJSUcU0C+lT7HmjgeqWfWUynaemYKLXgwn0acgFD4pQ1//u6klCjGTU+KrEWxIGEZQ
 SynPzmQ5wKJYt0aIzaa7hUTh7JiTcFM18HhEv68pr0yVHV9KBbRrcsuIKSsMqvNlGU0d
 ATQl1p1foTDAu7SljhcZNSGuUt0HEn6dQLhwSO3RPaHzmc/WgsCr+eSTP8StwUmK87Nh
 g+F34kBlwV9MqA0z4FBpuMaF6wAlDtrFxOGd0RBB+UmVPcuogYF/xOEMiFrIZ3z4yiJD
 tKbTOq8zw4lb7Xhp59GbIAfIz1IqZa2CuRXk5iVzT4tZt8ovbdciY3E7xxOLoT6PkMYC
 s+IQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByS+KM73Gst+jtCtBJ5qq01KspmW07WcemZ4dQG74+9pcbf1y9fiSQuAXpNxmY4Y5hWt9wpQvfiGew=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nsYoSdbXRMRsi0vzJ2EAEG3hpf9R8if7M8d86iI8IllBBffc2V
 /osix/Rs2kbM72hvO4inBqexn59Iu11iNtmubRjTpcoz4EmF6CUQTxmhpK4a+OxiW8AHC8hK95+
 TjeSaxzXr7nxLUq6Li7wwDs4jTMcXrTpiEpUiywzMC/bqx+AOgR7b2WSprs0evazer7FhBw==
X-Gm-Gg: AYBFou0W/wpzAVN6QjxaEO8SC476cbxlCDPZC8voAEWfF30vUZMFSwVzs5B7crhY+t9
 dN3hnTDI8tec2QASdwTxxoElj6gVVwATFxDJJyCM8jtRruvcMG3FBjcilE/FNlHBFo3vSg6uB09
 d9uuMqfHF/f0sXhcJYpGNjmoYtWNHUFp9u22ircWV2QIoY3kZw4+UYTC5X+j4J3Tl3bZcXUqagE
 ch/gDC4MyfarDNvjXnU1R4rGcBwkh2NAaQr9Npl3LgqtSnufTbsWRozTnbNdUNfKxgAbiPWISEp
 x0ctWaXzvxiiIPwk2W7hpEoX47I/C0d/4n7b2xkuyBAXI23b6xbB6L9aeeJpg2PSp6FjNTE=
X-Received: by 2002:a05:6102:54a5:b0:7a6:cd3d:4990 with SMTP id
 ada2fe7eead31-7ac1b1f5230mr528628137.1.1790104757831; 
 Tue, 22 Sep 2026 12:19:17 -0700 (PDT)
X-Received: by 2002:a05:6102:54a5:b0:7a6:cd3d:4990 with SMTP id
 ada2fe7eead31-7ac1b1f5230mr528584137.1.1790104757360; 
 Tue, 22 Sep 2026 12:19:17 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7abf02ef491sm851218137.0.2026.09.22.12.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:19:16 -0700 (PDT)
Message-ID: <a1a6f4726f715259e29951933ca2279edab16073.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp/mst: reject DPCD read/write on ports with ddps=0
From: lyude@redhat.com
To: Xiao Lu <xiaolu.xie@intel.com>, dri-devel@lists.freedesktop.org
Cc: David.Francis@amd.com, jani.nikula@linux.intel.com
Date: Tue, 22 Sep 2026 15:19:16 -0400
In-Reply-To: <20260922032632.1255353-1-xiaolu.xie@intel.com>
References: <a854ea37b4329d767d04eb0ef7975492aeac0038.camel@redhat.com>
 <20260922032632.1255353-1-xiaolu.xie@intel.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dSpPCdX6l70629Ki8-NBx23p61msbf1-xXg6C9npeXU_1790104758
X-Mimecast-Originator: redhat.com
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

Sounds great to me! Then this patch is:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Are you able to push this upstream or would you rather I push it?

On Tue, 2026-09-22 at 11:26 +0800, Xiao Lu wrote:
> On ..., Lyude Paul wrote:
> > I wonder if it's possible to introduce some sort of ddps check
> > within
> > drm_dp_send_dpcd_read/drm_dp_send_dpcd_write() that happens under a
> > lock which we also acquire during CSN handling...
>=20
> Thank you for the detailed explanation. I understand the proposed
> approach =E2=80=94 holding a dedicated lock around the ddps check and the
> queue_tx call, with the same lock held on the CSN ack side, so the
> ddps value used in the check always reflects the last ack'd CSN.
>=20
> That said, after looking at this more carefully, I think the current
> v2 change is sufficient for the following reasons:
>=20
> 1. The only paths that issue REMOTE_DPCD_READ/WRITE to downstream
> =C2=A0=C2=A0 ports without first verifying ddps are triggered during conn=
ector
> =C2=A0=C2=A0 probing in the driver's add_connector callback (e.g.
> =C2=A0=C2=A0 intel_dp_mst_read_decompression_port_dsc_caps() in i915/xe),=
 which
> =C2=A0=C2=A0 is called from drm_dp_mst_link_probe_work(). This probe work=
 fires
> =C2=A0=C2=A0 when the MST hub UFP is first connected, on topology resume,=
 and
> =C2=A0=C2=A0 on each CSN reception. The race window =E2=80=94 a downstrea=
m port gets
> =C2=A0=C2=A0 unplugged between the ddps check and the actual AUX transact=
ion
> =C2=A0=C2=A0 during a probe =E2=80=94 is extremely narrow in practice.
>=20
> 2. Our primary goal with this change is to eliminate unnecessary
> =C2=A0=C2=A0 REMOTE_DPCD_READ transactions that cause lighting delay at l=
ink
> =C2=A0=C2=A0 training time, rather than strict spec enforcement. We belie=
ve the
> =C2=A0=C2=A0 vast majority of MST hubs already handle reads/writes to unp=
lugged
> =C2=A0=C2=A0 downstream ports gracefully. DP v2.1b Table 2-199 describes =
the
> =C2=A0=C2=A0 DPCD_FAIL NAK with bad-param for such cases, and implementin=
g this
> =C2=A0=C2=A0 response in hub firmware should not impose significant burde=
n on
> the
> =C2=A0=C2=A0 hub.
>=20
> In summary, this is an optimization to improve latency rather than a
> correctness fix, and we consider the risk of the narrow race window
> acceptable.
>=20
> Best regards,
> Xiao Lu

