Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB29C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB1F10EA2B;
	Tue,  8 Sep 2026 07:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="NeWIk2SM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azolkn19010000.outbound.protection.outlook.com [52.103.12.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A908610E028;
 Mon,  7 Sep 2026 14:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwip5ePMz4uEPpLcK4THjFppEnabge++vyDN94Q9atYyIPAnUnkY7JnsKOBGUuaXUSND9JDSdAIG5NulLScCOUqRT9XdENHJuZ9DYXP8vCME4tG8lcDZGpGBUPCC/kstGN53FtT5chjf/KIT9Bxd6nbPJC3zr6KPS8x/MnuJdEYRqF0sPnceigc994eDFvPaH9C+kYOuFQaX2N+H16y8M/erYp4RRLXgSI8+JyL+ZQQvhCp48Uu1Y60gDj1VXxuKmZLLrmhDYRUSkwaOR17peBEIT65TIjXN4I8smvnnyBkfaSMxpg2AmPFBobcalKbStqva+VNcF442oUTjpS72JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohSMWJ8e7Dz6ZJyDC6o7mSMwxCrP/XnOaU36+BefuN8=;
 b=tTEMAPEK5ZWdd6t8XmGYff4tB8kL3rsPaZWHWQ1k5uNuqayDZOem8g1xZB+g+iTVZeEuaFWPLyVAJhDKaRwT6KjKKDCpIFsL42RsJ6p3mAvUbmVjzp/CCVIsG1Wo4DHZyhjQ/+UwtsqpSk/NPscr/WyWWkBFKW+mk6tQLBxz6BRk/qbl47XwPHo57ondHGlHMZvHnpC4IGeOyFvgXZMzaQNeVTfAXpT9WipGLkyYcr0bCg4brE4zISI8DNBOJZbTRHz/VgAHJuew4mhk1G7BtsEXzd5ZzBbpB0jlm0+fqzS6xaQvidBMaO7E7o08rKTHIirskjkBL8lYckMuchaqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohSMWJ8e7Dz6ZJyDC6o7mSMwxCrP/XnOaU36+BefuN8=;
 b=NeWIk2SM9EUHVm13a5G6lfvqvBF3Dh3kh7HuL9z27cqK/hCEGKakmYRDb/9L21CZ6epnsHizbJZGTzTN8uGPmGdx0wFfA87qefQj2NzIX92ai50GwJFkqV71xe8Ku0x9N2aG8IKWMA/p1w2oCprITsiMeTL+QEMx9aGTg4Tavk96ePyID7frTLZS6vE5p4oDapH0ebJFauroMKvJAjGGfCDQJOILydW/0k3snvK60whQlyAz6z3NfGedtvI2vjwkG8EAdG0tbAvhhEIxtKFbEbuXQE5Js2pGB5ESpBV/zxazeehH/WED5opBjG7hL0g1cCHzFf1CkMwcRYNBsESttA==
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com (2603:10d6:103:180::10)
 by SCYPR80MB7228.lamprd80.prod.outlook.com (2603:10d6:300:a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 14:52:16 +0000
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d]) by CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:52:16 +0000
From: Danilo Machado <danilomachado2002@hotmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux@leemhuis.info" <linux@leemhuis.info>
Subject: Re: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
Thread-Topic: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
Thread-Index: AQHdPthZkh+T8RZazECAp8xXMBtPcg==
Date: Mon, 7 Sep 2026 14:52:16 +0000
Message-ID: <CPUPR80MB658316FEDF6220A3DA27A276A3B22@CPUPR80MB6583.lamprd80.prod.outlook.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPUPR80MB6583:EE_|SCYPR80MB7228:EE_
x-ms-office365-filtering-correlation-id: 355c2530-3870-44fe-288c-08df0cef9c12
x-microsoft-antispam: BCL:0;
 ARA:14566002|24021099003|55001999006|15080799012|21061999006|51005399006|31061999003|5062599005|15030799006|41001999006|22091999003|25031999004|24121999003|4140399003|8062599012|8060799015|19110799012|25010399006|40105399003|1602099012|10035399007|2607281247196008|102099032|4302099013|440099028|3412199025;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?F/D8LBpcZw5eWKHjjL53rIKjKt3uQi7hyJE8DxZgC12I2ipRVwRdGQ0jKs?=
 =?iso-8859-1?Q?ahdUEDYrlW9Zqt+rhbotQw+roPfcinwY64Fit6/D1rdUkEKbH+X+vSLmgP?=
 =?iso-8859-1?Q?EXYuRkWZlgycrlkPDDwr2I9bgCd5EVuVMSzXJn1nf7H7c/NQuxniyi1PiN?=
 =?iso-8859-1?Q?+ukitAMgkQ6a0nlIUoJELfcQWMwzzIFA0yfebLFgySJ3SUfG28h/kZHixx?=
 =?iso-8859-1?Q?25kbMbUPrOhfJLkI9UVzfndrmMdcR7Uc+YWH5opuu6OZ9aWPVtXNQXQlB5?=
 =?iso-8859-1?Q?lzNF/NNZIK4wyzc8B2bnv0aQ4uuXxudmcUe/2mclKzJ3iqEB9fMkLZkYzq?=
 =?iso-8859-1?Q?t6t5Hj178Drc1yE9utaO+9gJ6WN/qOSQutWSsj7WVTwL3xRi31Gv1N//0O?=
 =?iso-8859-1?Q?K38VhUMdtC/pNOCBtcmAoRNH1Jgq/TAjDxMqW+Nnj1vK53Hh88pHYndGjs?=
 =?iso-8859-1?Q?Gb6JeDSEiR9AakEB7PL4ZL9o8vqRLJmonUtRDXcRA4uV5/QdshoXzuqN0i?=
 =?iso-8859-1?Q?J/zPMjsgtEimJGJhx3AZusq7c5i0/bbj4TW4treNvBPM4xwmKKhNdwKbAQ?=
 =?iso-8859-1?Q?N0+SGM7oNgDNAm/XhnLAbneXafeVc3p5pSSwUvEVbSHpTbR37huh3PegtM?=
 =?iso-8859-1?Q?73bi+tAPcVozhm204XHDWhyts6rE5pD/BUkAjivxwJBdj0rABT2v90jxvC?=
 =?iso-8859-1?Q?ou82Dz5isqFNKeA9MSvk7P9GjEwGdyQB8i6HbMoVIMROjYvFLgpZ7ydSZn?=
 =?iso-8859-1?Q?24YrXRsUcmcJvI8FByEFNn3p1/tX33w2oZ0Aqa7rvMDxc4TjRaNue5izWQ?=
 =?iso-8859-1?Q?PY8oAQOBvEw79o0pekFO6uDZxfCuRZ9ABr6ctUWu4ww3xvu8I+Wsy62OET?=
 =?iso-8859-1?Q?xX3qzxblN96DN9O73Athb5Vyoj2bPtQTWVlOLvXKvkW2/qC4IQ1i1MSuKG?=
 =?iso-8859-1?Q?vhB7n78QqFDz29RaoWRKjq18RblGCQMK+G99dIfDyRkRaC1T+QEBXXsowZ?=
 =?iso-8859-1?Q?JPMMhZmh4YTSAx4JY2bVM79PCGkmbMGjCtE/O8NH9nZ8nsubJ5Ps6G10Ht?=
 =?iso-8859-1?Q?y3WVtxJA+yEpFDOwI7iwkZm3BGCSLzEpp0DYg4h3tWCzqt8+3r9E5bcorv?=
 =?iso-8859-1?Q?MgBSaVsppNU47F52fyjjyiDyWDx4rC75APoCcLYTATR5QByM4nE+qWYq73?=
 =?iso-8859-1?Q?squRZP35PJ/tLS8GyNQPb7xrawJX8okC/hfHGuyabompsDgK7ZSyRgNbAj?=
 =?iso-8859-1?Q?k2x1IYQ4pUfQvQGdwIWzpwacl8OmZtbv8n80fv7L4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GmZcRnanqkOc4ezEGGwLDyExWiB6b8/AjpaXh2f4ovdG/6QvVTG8N7OGHM?=
 =?iso-8859-1?Q?rj3XQdTX5S8zBYheIgSw1U/GYIOYRoiwaLSUSfFozc2jp8q/19nT/Ot+RC?=
 =?iso-8859-1?Q?iF1ojujHrusD3NGjaFOXPseFByNtNHn6jeFwZhgHUic737EWaVTknEHfSd?=
 =?iso-8859-1?Q?oStaC5MNqUThik0EYiJgqUWPOiMNt6ROi5fYrvgPd9a4PJ3gXgIKYCtnsa?=
 =?iso-8859-1?Q?gWFhKaihudr/GTSIoEsHc1jwNK/H3+es2HApTVZOxbFwJiIyhNLS8s5SmM?=
 =?iso-8859-1?Q?RCyoabe/KoI/vLexXTbahhEPEC05Lete115YdhcCaZKQ7j7uuxOptF9XwK?=
 =?iso-8859-1?Q?ldHI6K3lMBddvlRJLGDLx4SRiPW6UyWl/Rf01dLMgraroguCoPoVj7Zo03?=
 =?iso-8859-1?Q?7qyeJF4mrJgA+bNovceHmq7suBfNW5b+lj+4ugIZZPQCvIRT6biElXlZrw?=
 =?iso-8859-1?Q?E/JMtFDCDLFrtTU/lAAJrKYmAZwFhJvm7EmSbaOYdqgJEh2oqvfxkfTwpS?=
 =?iso-8859-1?Q?iLLZTN5KfyvC45Lhqm0TW2STcPoa2/tD7AK1V1N9zG1BevYsWLuOcOFjfQ?=
 =?iso-8859-1?Q?VscL/KGO+T2tXZD7tPBLVgfZlk9+HsHWnSY8kQYbzVrnW7POzctUc547JH?=
 =?iso-8859-1?Q?mW9FYbYIVW2Mx50+7I69CzH9IPJj3/1DCh5FK0Z2eJhdzohxfrrqokW1IB?=
 =?iso-8859-1?Q?ylRUtu30MnWQsHKIVhCoDnq08qc66v89jEZGMXQOwSxonhtCMjRaLd14Ts?=
 =?iso-8859-1?Q?vLNjRQ56/WR+mCT39pNETntQe3VCz7RmuFUHgDtluVNDC+oMjMXCZv5lC4?=
 =?iso-8859-1?Q?bjotRqKdgs+DrU0PAVap6zlWPysB1jRObPFQD+DTlDUl3mu1lOGEMqbk8D?=
 =?iso-8859-1?Q?EfZ5y7LyqklDOFsRxQN+eqOP9gQYVLR23+157NFnfz99ctdsIuZ6V8nciq?=
 =?iso-8859-1?Q?bN4Q7MilvuUVctRRW9NBl9IaSzx0SQbNcje54XRW5HoWkCDNBugPZRCYhn?=
 =?iso-8859-1?Q?VxfXxsK9EgvZoNjTv89qHs036CwviLLojv6XtEQcr14/yokiGmMZMwKhv3?=
 =?iso-8859-1?Q?PxOGKFsyAt1Umjxp9u9li4+ButBVKUC6Ggs/zcLhTagbfWP5bpmeCPAOyb?=
 =?iso-8859-1?Q?sbIXyIc2l4Ght0o+bU695xsMZ0i/oTx5yyU5mEgX5w03i0X+EICGM0KkwF?=
 =?iso-8859-1?Q?1jI6P4eXVhy3oVr3XW/gTnBvd65FN1Im1XcXaE9OcETNKwwEDJ1jSrt+um?=
 =?iso-8859-1?Q?AeD+/xSEI/vKRW9WUUy5SOjUxVzZUXOb4MPZa2OCKTXYyGkD0ggRQg1Q7W?=
 =?iso-8859-1?Q?J57zGi0eeikL/r77vpSEOw3CFeeKdml+JoCGupLlBDW74Y5JSPnr1mWtg0?=
 =?iso-8859-1?Q?9MQ+RJO8qSQI0XJfSVJZFQnoQIgMkvMRHDUpOATQ80qc8n1fFS2wsy45S0?=
 =?iso-8859-1?Q?sriiuz1G7DztMfRwpBoAMhJykFAHHt9u/iNxoOhVSHFL2jpTo2tp5tq31b?=
 =?iso-8859-1?Q?NwT90WC7bI2aAVrmuC4A9MygRkhrQ9tgqol6hXmPzpiA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CPUPR80MB658316FEDF6220A3DA27A276A3B22CPUPR80MB6583lamp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-665fe.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPUPR80MB6583.lamprd80.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 355c2530-3870-44fe-288c-08df0cef9c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 14:52:16.4614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SCYPR80MB7228
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:44 +0000
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

--_000_CPUPR80MB658316FEDF6220A3DA27A276A3B22CPUPR80MB6583lamp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#regzbot back in-progress
#regzbot monitor https://bugs.launchpad.net/ubuntu/+source/linux/+bug/21423=
89
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

Hi Thorsten, Alex, and Linux Kernel Maintainers,

I am writing to update the status of this regression after checking the Reg=
zbot tracking dashboard:
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=
=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/

The dashboard currently lists this issue as "fizzled out / resolved: inconc=
lusive", but I want to clarify that this bug is ACTIVE, UNRESOLVED, and act=
ively tracked. The lack of recent email activity on LKML was due to ongoing=
 technical data collection on Launchpad and GitLab while awaiting upstream =
feedback.

Current Status & Verification:

1. Launchpad Report (#2142389):
   - Status: Confirmed (assigned to maintainer Timo Aaltonen).
   - Heat/Users: 220 Bug Heat points with 44+ explicitly confirmed affected=
 users across various AMD architectures (Tonga R9 380, Polaris RX 400/500, =
and recent Vega APUs).
   - Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389

2. Freedesktop GitLab Issue (#5123):
   - Status: Open.
   - Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

3. Technical Summary:
   - I have executed 3 full git bisect routines on hardware testbenches, is=
olating the regression behavior between kernel transitions.
   - Recent user reports confirm the same black screen / no EDID handshake =
failure upon resume and DPMS display wake-up across multiple Linux distribu=
tions (Ubuntu, Fedora, Void Linux) and kernel versions (up to kernel 7.0).

Please re-open and maintain active tracking for this regression on Regzbot.=
 I remain available to test candidate patches, kernel builds, or debug flag=
s on physical hardware.

Best regards,
Danilo Machado

--_000_CPUPR80MB658316FEDF6220A3DA27A276A3B22CPUPR80MB6583lamp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#regzbot back in-progress</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#regzbot monitor https://bugs.launchpad.net/ubuntu/+source/linux/+bug/21423=
89</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123</=
div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Thorsten, Alex, and Linux Kernel Maintainers,</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I am writing to update the status of this regression after checking the Reg=
zbot tracking dashboard:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=
=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The dashboard currently lists this issue as &quot;fizzled out / resolved: i=
nconclusive&quot;, but I want to clarify that this bug is ACTIVE, UNRESOLVE=
D, and actively tracked. The lack of recent email activity on LKML was due =
to ongoing technical data collection on Launchpad
 and GitLab while awaiting upstream feedback.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Current Status &amp; Verification:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
1. Launchpad Report (#2142389):</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Status: Confirmed (assigned to maintainer Timo Aaltonen).</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Heat/Users: 220 Bug Heat points with 44+ explicitly confirme=
d affected users across various AMD architectures (Tonga R9 380, Polaris RX=
 400/500, and recent Vega APUs).</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2=
142389</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
2. Freedesktop GitLab Issue (#5123):</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Status: Open.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/51=
23</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
3. Technical Summary:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- I have executed 3 full git bisect routines on hardware testb=
enches, isolating the regression behavior between kernel transitions.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- Recent user reports confirm the same black screen / no EDID =
handshake failure upon resume and DPMS display wake-up across multiple Linu=
x distributions (Ubuntu, Fedora, Void Linux) and kernel versions (up to ker=
nel 7.0).</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Please re-open and maintain active tracking for this regression on Regzbot.=
 I remain available to test candidate patches, kernel builds, or debug flag=
s on physical hardware.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Best regards,</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Danilo Machado</div>
</body>
</html>

--_000_CPUPR80MB658316FEDF6220A3DA27A276A3B22CPUPR80MB6583lamp_--
