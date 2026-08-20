Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9767FC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F9F10F17E;
	Thu, 20 Aug 2026 19:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8RENewc";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32D310F17E
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:35:35 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9b3f380006so32468a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 12:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787254535; cv=none;
 d=google.com; s=arc-20260327;
 b=Sz9tiQIb04qSfAHk29T/mOoTidGL+HzaVeFDFkMRpkRT7zNQtdJbLK4Kz5AcMMc43w
 Mt/GC/u2M8iMVBSriZHGSm3OqSXrMPtkuVB2z7euit05n+YDmKQmWBHkTmOS+1zHD7Ti
 FNd5CzDwtok5jiyBSn0t+BzHACsV6WWPUQ8vS1nJVKGEHoSInuqIN48toTdaP64GRagu
 X4c9JZk6mhVWUr6yuPn0QrThf794nrTaGF2nangeVvtfxyu12hUEpKJpH6Wu1rWeZoRs
 TBTC0N818ZSEbbUG7tLIHZXP1bZkbFWoHHM4pwuZRBkwNIfJ9LluOxHjIjqj9iwOQjfW
 gvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gqytTIc7u2uOtpbZfg574tdAzUb/kPMViOM7fTVII1Y=;
 fh=v0MEAqPOChWExHqcAyLBP/XU5unWpLQPQS4B0vZZTPg=;
 b=khktx+28qQP3v0mou0PVzPzY399nbC/Ks/nTDfpFqUiiRlJ1xINfu3p16s5UNt5TIY
 QjQYHvw1N/Sg1J/F2cKnyrrwI/KufC5jLhm7krQdO1kiJBB3aX39C+k3uAWUQqFGpCOA
 /+2SH107hzaO6KfjY74ECTJKWI5I99wME0PRjK7XfNG0vPBCtcN8wAuYFCDwuhMBYq6p
 kCwHTHd48Mb+k+581pnspPFfior+m5hHfClH1Cppg35PmEbgWvClzLI4ZwFGpfc59FwJ
 W0TScZOj+rt5izQ2EA8wZJhKKNrK6eq2NjbbBa3CszYl6kf7k8L9l24Jtf+YHMFhyNfP
 6ybw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787254535; x=1787859335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gqytTIc7u2uOtpbZfg574tdAzUb/kPMViOM7fTVII1Y=;
 b=h8RENewcf4Hc6WiVMeCucYhLVj5uwGpTqd22bQ4KHmH52we8RYPTGwda4wjq/IUL1Z
 qLv0oDTqllAwF85xAjUUadFxqHD+Nd4ZgZWkVthGayvw3gBbEMkzGl6rTcwWP8azYLWV
 gIPO5XDaK8WM2cZ9Y2T2zS5JuNXAoqV4TV9DN1LDt1GKc+YX3ADWibCzm0AEdzGBkPXT
 AAkjpPALoOXv0ZRq93AJPK7YQSRYo5NWHGKWGJCWsIRnVm7zp8BjlWqS0dsC8BMR7+aD
 KcAzfw1asTVoI2wFMI9Fip7o5zYm9fkSnoLrSotf8JbclDer4ozYJ5eugbiytIWl5ivV
 4SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787254535; x=1787859335;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gqytTIc7u2uOtpbZfg574tdAzUb/kPMViOM7fTVII1Y=;
 b=TdRsbnD5LeBSw8ccuPtihMmtDnWF0a22XRhQJY8mh5Ngd1isTeVd2Bg7iRgGoE3EeI
 oZv8p9DYaY52tD4qwyyF68eweiuEetruRKth7E0hP4limxe2IxMFE/IxPm1KRws6do3E
 1Tk4h6hHChPh6ZXl63IOYHJQOdHb0KhdXskfOasTEO5gs4Dc5nBBD0PeNbckz06SkMn2
 i60G2v7klebjR9qNiCX2zyABHeT/dMFiJuKj0Ynhu4bJXIINBbmbLFQitCLpSQ7B8O5V
 8rHNkFAC2lGTXbeldjC6QBZQDhpk+YaFtHM1kcMvhYDF/mTO1rwpedRRnhiNDiWDHR1G
 IFCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro16R7W83TolEeFKP0J6lX0A4NbiQtsVdvUCfJn+F6QNgnD0x1CZvLLlq7cXJINk3bFeZ38aSiXbd8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntND8/jqnMV6j/LkYKpMm24inJm975Z78dbRLIPMawRpHNYsJo
 GjAcfJcO8l1TYGKtMv58jaDQRu1eAEzLzoPJ04lyEb3Cs61C6+W8jpGfYTSi3CJUxEhT4+52P/M
 jJKKWpVJfNnCDx6P+mxK2emzxe7GvHk0jgQ==
X-Gm-Gg: AR+sD13gNgV1+hYiQHbCDXEvj12qjW6DnRnxaQsucY2RfYrRfFQC64WnyPK4RxA44/a
 lDDAfg4Pv7NYcsiYZuGGHElSxuOijx5g26Crw5Aex6Wkh3Nh9xtTuaCTDsI/ls6asEpLomEAwNC
 Ny+lZGI/cK3afa2T7fm8uTnq3khSOX4Bkov1BejioaRCi+ZmRmHaEDcW+qzMoeu0xAOguXieL31
 nlN6sN3AEy8XZPhUCtj4vDAwV7Vq572DftGBVJG+ZKCNxFL+zy4RkDRkqW99+ne9SKvw/MhhMlZ
 LdIyOolp8fiE619GeURLRmKNupEGIRG6YqcqY3oIBi0MKWUHi5kKr4QDYfxDSxhB2nwCNpcHFk9
 B2yggVWelAOoUa43xK23XPNGP4poceGU=
X-Received: by 2002:a17:90b:1b03:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-395c35d68demr662214a91.4.1787254535103; Thu, 20 Aug 2026
 12:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
 <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
In-Reply-To: <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 15:35:23 -0400
X-Gm-Features: AcwNN1UwFcHSw7D74U3tBOLcfnE6T2qJeXaLFCpWNAHVx_ZWYlTuFww1BcGCv8I
Message-ID: <CADnq5_PvMKVbmukOJW9oHK-bw3110eAf97WXfUVi-urhcEGMMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
To: Mario Limonciello <superm1@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Alex Huang <Alex.Huang2@amd.com>
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

On Thu, Aug 20, 2026 at 3:30=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 8/20/26 09:28, Rodrigo Vivi wrote:
> > parse_hdmi_amd_vsdb() was removed when HDMI FreeSync detection moved to
> > the common EDID parser, but its declaration and KUnit tests remained,
> > breaking modpost:
> >
> >    ERROR: modpost: "parse_hdmi_amd_vsdb" [...connector_test.ko] undefin=
ed!
> >
> > Remove the stale declaration and the three dead test cases.
> >
> > Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from com=
mon EDID parser")
> > Cc: Alex Huang <Alex.Huang2@amd.com>
> > Cc: Mario Limonciello <superm1@kernel.org>
> > Assisted-by: Copilot:Claude-Opus-5
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> Thanks this looks correct to me.
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> I'm not sure where we should apply it though, it's from a conflict
> between drm-misc-next and Alex's drm-next pull.

I'll pull it into my next -fixes PR.

Alex

> >   .../display/amdgpu_dm/amdgpu_dm_connector.h   |  3 -
> >   .../tests/amdgpu_dm_connector_test.c          | 73 ------------------=
-
> >   2 files changed, 76 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.=
h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> > index 4e9eb3ff2c90..ce900844602e 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> > @@ -153,9 +153,6 @@ void parse_edid_displayid_vrr(struct drm_connector =
*connector,
> >                             const struct edid *edid);
> >   int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> >                struct amdgpu_hdmi_vsdb_info *vsdb_info);
> > -int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> > -                     const struct edid *edid,
> > -                     struct amdgpu_hdmi_vsdb_info *vsdb_info);
> >   void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)=
;
> >   enum dc_status dm_validate_stream_and_context(struct dc *dc,
> >                                             struct dc_stream_state *str=
eam);
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_conn=
ector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connec=
tor_test.c
> > index a54fd9529dc9..83d3be543202 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_t=
est.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_t=
est.c
> > @@ -4874,75 +4874,6 @@ static void dm_test_get_amd_vsdb_supported(struc=
t kunit *test)
> >       KUNIT_EXPECT_TRUE(test, vsdb_info.replay_mode);
> >   }
> >
> > -/**
> > - * dm_test_parse_hdmi_amd_vsdb_null_edid - Test NULL EDID returns -ENO=
DEV
> > - * @test: The KUnit test context
> > - */
> > -static void dm_test_parse_hdmi_amd_vsdb_null_edid(struct kunit *test)
> > -{
> > -     struct amdgpu_dm_connector *aconnector;
> > -     struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
> > -
> > -     aconnector =3D kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNE=
L);
> > -     KUNIT_ASSERT_NOT_NULL(test, aconnector);
> > -
> > -     KUNIT_EXPECT_EQ(test,
> > -                     parse_hdmi_amd_vsdb(aconnector, NULL, &vsdb_info)=
,
> > -                     -ENODEV);
> > -}
> > -
> > -/**
> > - * dm_test_parse_hdmi_amd_vsdb_no_extensions - Test EDID without exten=
sions
> > - * @test: The KUnit test context
> > - *
> > - * An EDID that declares no extension blocks has no CEA block to parse=
.
> > - */
> > -static void dm_test_parse_hdmi_amd_vsdb_no_extensions(struct kunit *te=
st)
> > -{
> > -     struct amdgpu_dm_connector *aconnector;
> > -     struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
> > -     struct edid *edid;
> > -
> > -     aconnector =3D kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNE=
L);
> > -     KUNIT_ASSERT_NOT_NULL(test, aconnector);
> > -     edid =3D kunit_kzalloc(test, sizeof(*edid), GFP_KERNEL);
> > -     KUNIT_ASSERT_NOT_NULL(test, edid);
> > -
> > -     edid->extensions =3D 0;
> > -
> > -     KUNIT_EXPECT_EQ(test,
> > -                     parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info)=
,
> > -                     -ENODEV);
> > -}
> > -
> > -/**
> > - * dm_test_parse_hdmi_amd_vsdb_no_cea_ext - Test EDID with no CEA exte=
nsion
> > - * @test: The KUnit test context
> > - *
> > - * An extension block that is not a CEA block leaves no VSDB to parse.
> > - */
> > -static void dm_test_parse_hdmi_amd_vsdb_no_cea_ext(struct kunit *test)
> > -{
> > -     struct amdgpu_dm_connector *aconnector;
> > -     struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
> > -     struct edid *edid;
> > -     u8 *raw;
> > -
> > -     aconnector =3D kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNE=
L);
> > -     KUNIT_ASSERT_NOT_NULL(test, aconnector);
> > -
> > -     /* Base block + one extension block that is NOT a CEA extension. =
*/
> > -     raw =3D kunit_kzalloc(test, 2 * EDID_LENGTH, GFP_KERNEL);
> > -     KUNIT_ASSERT_NOT_NULL(test, raw);
> > -     edid =3D (struct edid *)raw;
> > -     edid->extensions =3D 1;
> > -     raw[EDID_LENGTH] =3D DM_TEST_DISPLAYID_EXT;
> > -
> > -     KUNIT_EXPECT_EQ(test,
> > -                     parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info)=
,
> > -                     -ENODEV);
> > -}
> > -
> >   /**
> >    * dm_test_parse_displayid_vrr_null_edid - Test NULL EDID leaves rang=
e untouched
> >    * @test: The KUnit test context
> > @@ -5647,10 +5578,6 @@ static struct kunit_case amdgpu_dm_connector_tes=
ts[] =3D {
> >       /* get_amd_vsdb */
> >       KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
> >       KUNIT_CASE(dm_test_get_amd_vsdb_supported),
> > -     /* parse_hdmi_amd_vsdb */
> > -     KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_null_edid),
> > -     KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_extensions),
> > -     KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_cea_ext),
> >       /* parse_edid_displayid_vrr */
> >       KUNIT_CASE(dm_test_parse_displayid_vrr_null_edid),
> >       KUNIT_CASE(dm_test_parse_displayid_vrr_no_displayid),
>
