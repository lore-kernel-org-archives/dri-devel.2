Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B4606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=Cza/3h8L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=tempos-project.org header.i=@tempos-project.org header.a=rsa-sha256 header.s=dkim header.b=j0vRwJtt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=cicWMGTS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4DB10E1DD;
	Wed, 25 Nov 2026 08:41:18 +0000 (UTC)
Received: from mail.renesp.com.br (mail.renesp.com.br [45.231.133.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA3110F68D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
 s=2021; t=1795531055;
 bh=pPSDomr6w5PDjyvm65w3PDJSCglsH0Sppc05pvIRGy0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Cza/3h8LjoylyY1gOe2L6OsNtoMHTn/1lcn++DVV+3NEoWyh5tjXhXKNmNme0+znS
 7wAS2/Hxd40Bhy/7KkDqxpKd6fkh1p95F9VKqjo4Np/s0w62X/b5AhkmzaEr0jqX5B
 lv2UYqCXNPNIdXyrbRuGFSPj59Grq4fidx4nigTA=
Received: from renesp.vps (renesp.com.br [127.0.0.1])
 by mail.renesp.com.br (Postfix) with ESMTP id 4jYllM60Jdz3wvN
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:37:35 -0300 (-03)
Authentication-Results: renesp.vps (amavis); dkim=pass (1024-bit key)
 reason="pass (just generated, assumed good)" header.d=tempos-project.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 tempos-project.org; h=content-transfer-encoding:content-type
 :message-id:user-agent:references:in-reply-to:subject:to:from
 :date:mime-version; s=dkim; t=1795531054; x=1798123055; bh=pPSDo
 mr6w5PDjyvm65w3PDJSCglsH0Sppc05pvIRGy0=; b=j0vRwJttvjmAC5eu7VaAs
 kCd0+0C8rU4g1a6pMXTB3sO4LwGeC5MRs2me5oeVOhiGTENHlLcyd5BUu6GrTkJm
 5GSqBKrjG1fUsljCh/wkerXUkGIAiZeV7pebR31twxedGGu+xLwhzCjiwFTto9ER
 sI6uoVdND0oAnrBj7143Gmx9mi2priPnHqOkTr3DeYo5+b8Jzn6R8MW58f/Gsh2K
 hNKBOD0jo0/1iVuk7PLcVCRVhTYIHNLAsYrcDTWA7bku1VDKUcYHC0NpUaAfFPcu
 FcmgidjTioZwOn/rB467Cn1ElmX8k8qQ2rNmXqFBTwecd5Pjd9IH6EbiRoDrZJj/
 g==
X-Virus-Scanned: Debian amavis at renesp.vps
X-Spam-Score: 2.21
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: renesp.vps (amavis); dkim=fail (1024-bit key)
 reason="fail (body has been altered)" header.d=renesp.com.br
Received: from mail.renesp.com.br ([127.0.0.1])
 by renesp.vps (renesp.vps [127.0.0.1]) (amavis, port 10026) with ESMTP
 id ULMJt_0z9vRX for <dri-devel@lists.freedesktop.org>;
 Tue, 24 Nov 2026 11:37:34 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
 s=2021; t=1795531053;
 bh=8HJEpri4ciZWRWztrYhoc9FPK/buajQXTwjE2oYoJ/8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cicWMGTS6xwhSJeAOivubid0Sb4A1x7CyG4TdKaIuPOhmQSR7PAWBy5b/jB0O37am
 I2Y099tKSgeyDxxcQMj6iCtEx09ZVsg8At7d+1Ka+wsppKw1J8A8smsBX0d4PTXw64
 i94nr8Wk9S4pJSh+qL18oaNdCGIZP5hLpsd/MKzQ=
Received: from mail.renesp.com.br (renesp.com.br [127.0.0.1])
 by mail.renesp.com.br (Postfix) with ESMTPSA id 4jYllJ5ZH6z3wvJ;
 Tue, 24 Nov 2026 11:37:32 -0300 (-03)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 15:37:32 +0100
From: =?UTF-8?Q?Ren=C3=AA?= <rene@renesp.com.br>
To: Murali Krishna <muralikrishna2444b@gmail.com>
Cc: srini@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, anandu.e@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] misc: fastrpc: fix fastrpc_user leak on abnormal process
 exit
In-Reply-To: <20261124142229.88456-1-muralikrishna2444b@gmail.com>
References: <20261124122011.2912030-1-rene@renesp.com.br>
 <20261124142229.88456-1-muralikrishna2444b@gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <c1ab68b4eb9a07813fd31fd110955c8e@renesp.com.br>
X-Sender: rene@renesp.com.br
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Murali,

Thanks for going through it.

On the overlap: I missed Anandu's series when sending this, sorry. v2
is already out, but v4 of Anandu's series fixes the same leak more
completely: it also releases the DSP reference when the process
teardown succeeds, which covers your second point. Srini, if you prefer
that series, please drop mine; it was only meant to fix the leak.

Anandu, I can reproduce the leak on a QCS8275 (IQ-8275 EVK) by killing a
process with CDSP invocations in flight, and will test your v4 there.

Thanks,
Ren=C3=AA


On 2026/11/24 15:22, Murali Krishna wrote:
> On Tue, 24 Nov 2026 13:20:11 +0100, Ren=C3=AA de Souza Pinto wrote:
>> Since commit e85eb5feca8e ("misc: fastrpc: fix use-after-free of
>> fastrpc_user in workqueue context"), each invoke context holds a
>> reference on its fastrpc_user, while contexts left on the pending list
>> (interrupted or timed out invocations) are only freed by
>> fastrpc_user_free(). When a process dies with invocations in flight,
>> this cycle leaks the user with all its maps and buffers.
>=20
> I am new to this driver, so please treat the below as observations
> rather than a review. I read the context lifetime in char-misc-next
> (917fcbf03) and it does appear to support your description:
>=20
>   - fastrpc_context_alloc() takes fastrpc_channel_ctx_get(cctx) and
>     fastrpc_user_get(user), links the context onto fl->pending, and
>     kref_init()s the context.
>   - fastrpc_invoke_send() takes a second context reference for the DSP,
>     released by put_work from fastrpc_rpmsg_callback(), or immediately
>     if rpmsg_send() fails.
>   - fastrpc_internal_invoke() unlinks the context and drops the first
>     reference in its bail path, but only when err is neither
>     -ERESTARTSYS nor -ETIMEDOUT.
>   - fastrpc_context_free() never touches fl->pending; it ends with
>     fastrpc_user_put(fl) and fastrpc_channel_ctx_put(cctx).
>=20
> fl->pending is referenced in only four places in the file: the
> INIT_LIST_HEAD() in fastrpc_device_open(), the list_add_tail() in
> fastrpc_context_alloc(), the drain loop in fastrpc_user_free(), and
> fastrpc_notify_users(), which sets -EPIPE and completes waiters but
> neither unlinks nor drops a reference.
>=20
> So for an interrupted or timed out invoke the first reference is never
> dropped, and the only other place that drops it is the drain loop in
> fastrpc_user_free(), which cannot run while any context still holds a
> reference on fl. That matches the cycle you describe.
>=20
> Two things I was unsure about.
>=20
> First, this looks like it overlaps with Anandu Krishnan E's series,
> now at v4:
>=20
>  =20
> https://lore.kernel.org/linux-arm-msm/20261117-interrupted-invoke-v4-v4=
-0-2320a8a7eda2@oss.qualcomm.com/
>=20
> I see you have Anandu on Cc, so this may already be understood, but as
> the two fix the same leak in different places it would help to know
> which is meant to land.
>=20
>> No thread can be in an ioctl on the file at release time, so drop the
>> references of the pending contexts there. A context still waiting for
>> the DSP response is freed when it arrives.
>=20
> Second, about the symptom in your test report. If a context is still
> waiting for the DSP, the put added here only drops the first reference;
> the DSP reference keeps the context alive, so fastrpc_map_put() on its
> maps runs later, from fastrpc_context_free(). The maps are attached to
> the session device (dma_buf_attach(map->buf, sess->dev) in
> fastrpc_map_create()) and the attachment is only torn down in
> fastrpc_free_map(). fastrpc_session_free() runs immediately after your
> loop and only sets session->used =3D false, so the context bank becomes
> available to the next process while those attachments are, as far as I
> can tell, still in place.
>=20
> Does fastrpc_release_current_dsp_process() above guarantee the DSP has
> drained everything by this point, so that case cannot occur in
> practice? If not, the window you are aiming at would seem to remain for
> genuinely in-flight contexts.
>=20
>> +	list_for_each_entry_safe(ctx, n, &orphans, node) {
>> +		list_del_init(&ctx->node);
>> +		fastrpc_context_put(ctx);
>> +	}
>=20
> Very minor: after list_splice_init() the entries are already off
> fl->pending, and list_for_each_entry_safe() does not need them removed,
> so the list_del_init() looks redundant.
>=20
> For what it is worth, the patch applies cleanly to char-misc-next at
> 917fcbf03 and builds there on x86_64 with COMPILE_TEST=3Dy under W=3D1 =
C=3D1,
> with no new warnings from either gcc or sparse against the unpatched
> file. I have no Qualcomm hardware, so none of it is runtime tested and
> I could not reproduce your leak; the rest is from reading the code.
>=20
> Thanks,
> Murali Krishna
